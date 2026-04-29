import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/features/shop/models/shoe_model.dart';

class Cart extends ChangeNotifier {
  // list of shoes for sale (The shop)

  List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom FREAK',
      price: '236',
      description: 'The forward-thinking design of his latest signature shoe.',
      imagePath: 'assets/images/zoomfreak.png',
      isBestSeller: false,
      detail:
          'As the first signature shoe for Giannis Antetokounmpo, the Zoom Freak line was built to support his explosive, multi-positional game. Giannis, known as the "Greek Freak," needed a shoe that could handle his signature Euro-step. Nike engineered this line with extra multidirectional traction and a unique reverse Swoosh, making it instantly iconic on the court and a favorite for players needing elite agility.',
    ),
    Shoe(
      name: 'Air Jordan',
      price: '220',
      imagePath: 'assets/images/jordan.png',
      description:
          'You\'ve got the hops and the speed-lace up in shoes that enhance...',
      isBestSeller: true,
      detail:
          'The sneaker that changed everything. Originally released in 1985 for Michael Jordan, the Air Jordan line birthed modern sneaker culture. Legend has it that the NBA banned the original black and red colorway for violating uniform policy, fining Jordan \$5,000 every time he wore them. Nike paid the fines, the controversy fueled the hype, and a global streetwear phenomenon was born.',
    ),
    Shoe(
      name: 'KD Trey 5',
      price: '240',
      imagePath: 'assets/images/kd5.png',
      description:
          'A secure fit is essential for KD to go all out on the court.',
      isBestSeller: true,
      detail:
          'Named as a nod to Kevin Durant\'s social media handle and his original jersey number, the KD Trey 5 line acts as the versatile, everyday workhorse of KD\'s signature collection. It was designed to offer premium Nike technologies—like Renew foam cushioning—at a more accessible price point. It quickly became a staple for streetballers and gym rats who needed durable, lightweight comfort for all-day play.',
    ),
    Shoe(
      name: 'Kyrie 6',
      price: '190',
      imagePath: 'assets/images/kyrie.png',
      description: 'Bouncy cushioning is paired with soft yet supportive foam.',
      isBestSeller: true,
      detail:
          'Built for the most unpredictable ball handler in the league, the Kyrie 6 focuses entirely on control and traction. The design brought back the beloved midfoot strap for a locked-down fit and featured a 360-degree traction pattern that wraps up the sides of the shoe. This allows for extreme, low-to-the-ground crossovers without slipping. Its bold, eye-catching colorways made it an instant streetwear staple.',
    ),
    Shoe(
      name: 'Air Max 270',
      price: '160',
      imagePath: 'assets/images/airmax.png',
      description:
          'Legendary Air gets lifted. Our first lifestyle Air Max brings you style.',
      isBestSeller: false,
      detail:
          'Released in 2018, the Air Max 270 made history as Nike\'s first-ever Air Max shoe designed entirely for lifestyle and casual wear, rather than running. Inspired by the vintage Air Max 93 and 180, it features a massive 32-millimeter tall heel unit—offering 270 degrees of visible Air cushioning. It became a massive commercial success due to its incredible all-day comfort and sleek, modern aesthetic.',
    ),
  ];
  // list of items in user cart
  List<Shoe> userCart = [];

  // get list of shoes for sale
  List<Shoe> getShoeList({bool onlyHotPicks = false}) {
    if (onlyHotPicks) {
      return shoeShop.where((shoe) => shoe.isBestSeller).toList();
    }
    return shoeShop;
  }

  // get cart
  List<Shoe> getCart() {
    return userCart;
  }

  // add items to the cart
  Future<void> addItemToCart(Shoe shoe) async {
    // add it to local screen instantly
    userCart.add(shoe);
    notifyListeners();

    // check if the user is currently logged in
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // if they are logged in save the cart to database
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
              'cart': FieldValue.arrayUnion([shoe.toMap()]),
              // FieldValue.arrayUnion adds this item to the list without deleting the old ones!
            });
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future<void> removeItemFromCart(Shoe shoe) async {
    userCart.remove(shoe);
    notifyListeners();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
              'cart': FieldValue.arrayRemove([shoe.toMap()]),
              // FieldValue.arrayUnion adds this item to the list without deleting the old ones!
            });
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  String calculateTotal() {
    // userCart.map((shoe) {
    //   totalPrice += double.parse(shoe.price);
    // });
    double result = userCart.fold(
      0,
      //(previousValue, element) => previousValue + double.parse(element.price),
      (sum, shoe) => sum + double.parse(shoe.price),
    );
    return result.toStringAsFixed(2);
  }

  Future<void> fetchUserCart() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      userCart = [];
      notifyListeners();
      return; // Stop here! Don't try to call Firestore.
    }
      try {
        // 1. Go to this exact user's cloud file
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          // grab the map of data from the document
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          // extract the cart from the data
          List<dynamic> cloudCart = userData['cart'] ?? [];

          // convert the cloudCart data into list of shoe objects
          userCart = cloudCart.map((item) => Shoe.fromMap(item)).toList();
          notifyListeners();
        }
      } catch (e) {
        throw Exception(e);
      }

  }
}
