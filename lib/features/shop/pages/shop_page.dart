import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/core/widgets/my_textfield.dart';
import 'package:sneaker_app/features/cart/providers/cart_provider.dart';
import 'package:sneaker_app/features/shop/models/shoe_model.dart';
import 'package:sneaker_app/features/shop/pages/detail_page.dart';
import 'package:sneaker_app/features/shop/services/firbase_auth.dart';
import 'package:sneaker_app/features/shop/services/firestore_services.dart';
import 'package:sneaker_app/features/shop/widgets/shoe_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedIndex = 0;
  final List viewChanger = ['Hot Picks', 'See All'];
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // We use listen: true (default) because we want the UI to rebuild when the cart updates
    final sizeHeight = MediaQuery.sizeOf(context).height;
    final sizeWidth = MediaQuery.sizeOf(context).width;
    final cartProvider = Provider.of<Cart>(context);
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SingleChildScrollView(
      physics: isKeyboardOpen
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Column(
          children: [
            // --- TOP TEAL HEADER ---
            Container(
              height: sizeHeight*0.35,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.teal[500],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: sizeHeight *0.04,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                      FutureBuilder(
                        future: FirebaseAuthService().getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircleAvatar(
                              backgroundColor: Colors.teal[300],
                              radius: 18,
                            );
                          }

                          // SAFE CHECK: Removed '!' and added null checks for Guests
                          if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
                            final data = snapshot.data!;
                            final userData = data.data() as Map<String, dynamic>?;

                            final String userName = userData?['userName'] ?? 'Guest';
                            final String initial = userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : 'G';

                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: Text(
                                initial,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[900],
                                ),
                              ),
                            );
                          }

                          // Fallback Icon for Guests
                          return const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 22,
                            child: Icon(Icons.person, color: Colors.teal),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    textColor: Colors.white,
                    controller: _searchController,
                    hint: "  'Search anything' -",
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 34,
                      color: Colors.white,
                    ),
                    fillColor: Colors.teal[900],
                    filled: true,
                    hintColor: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "everyone flies.. some fly longer than others",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- TOGGLE BUTTONS ---
                  Container(
                    height: sizeHeight*0.075,
                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewChanger.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:  sizeWidth * 0.13),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                viewChanger[index],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected
                                      ? Colors.teal.shade500
                                      : Colors.teal.shade900,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeHeight*0.04),

            // --- STREAM BUILDER (No Expanded inside SingleChildScrollView) ---
            StreamBuilder<List<Shoe>>(
              stream: FirestoreServices().getShoeStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something Went Wrong'));
                }
                if (snapshot.hasData) {
                  final allShoesFromCloud = snapshot.data!;
                  final displayShoes = _selectedIndex == 0
                      ? allShoesFromCloud.where((shoe) => shoe.isBestSeller).toList()
                      : allShoesFromCloud;

                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: displayShoes.length,
                      itemBuilder: (context, index) {
                        final currentShoe = displayShoes[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(shoe: currentShoe),
                              ),
                            );
                          },
                          child: ShoeTile(
                            shoe: currentShoe,
                            onTap: () {
                              cartProvider.addItemToCart(currentShoe);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${currentShoe.name} added to cart'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}