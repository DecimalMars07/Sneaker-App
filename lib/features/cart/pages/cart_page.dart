import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/features/cart/providers/cart_provider.dart';
import 'package:sneaker_app/features/shop/pages/detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Cart>(context, listen: false).fetchUserCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<Cart>(context);
    final cart = value.getCart();
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 30)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final shoe = cart[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(shoe: shoe),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 4.0, // Adds a drop shadow

                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(shoe.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            shoe.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '\$ ${shoe.price}',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              value.removeItemFromCart(shoe);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${shoe.name} deleted from cart',
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total :',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        ' \$${value.calculateTotal()}',
                        style: TextStyle(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent.shade700,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          side: BorderSide(
                            color: Colors.teal.shade900,
                            width: 2,
                          ),
                        ),

                        child: Row(
                          children: [
                            Text(
                              'Check Out',
                              style: TextStyle(
                                color: Colors.teal.shade900,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.shopping_cart,
                              size: 25,
                              color: Colors.teal.shade900,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(thickness: 2, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
