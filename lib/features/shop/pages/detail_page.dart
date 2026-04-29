import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/features/cart/providers/cart_provider.dart';
import 'package:sneaker_app/features/shop/models/shoe_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.shoe});
  final Shoe shoe;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List shoeSize = ['7', '8', '9', '10', '11'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text(
          'FootShop',
          style: TextStyle(
            fontSize: 24,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 30)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(widget.shoe.imagePath, fit: BoxFit.fitWidth),
            ),
            SizedBox(height: 25),
            Container(
              height: 400,
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.shoe.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.black, Colors.grey.shade700],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '# Hot Pick',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '\$${widget.shoe.price}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        ' inclusive of all taxes',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                    ],
                  ),

                  Divider(color: Colors.grey.shade800),

                  SizedBox(height: 2),
                  Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final size = shoeSize[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                                print(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),

                              height: 40,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.teal.shade200
                                    : Colors.grey.shade100,
                                border: currentIndex == index
                                    ? Border.all(
                                        color: Colors.teal.shade800,
                                        width: 2,
                                      )
                                    : Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    color: currentIndex == index
                                        ? Colors.teal.shade900
                                        : Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: shoeSize.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.shoe.detail),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal.shade400,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.favorite_border_outlined,
                size: 30,
                color: Colors.teal,
              ),
            ),
            GestureDetector(
              onTap: () {
                value.addItemToCart(widget.shoe);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.shoe.name} added to the cart'),
                  ),
                );
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 55),

                decoration: BoxDecoration(
                  color: Colors.teal.shade900,

                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      '  Add to Bag',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
