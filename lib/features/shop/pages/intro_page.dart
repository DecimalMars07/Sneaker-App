import 'package:flutter/material.dart';
import 'package:sneaker_app/features/shop/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset(
                'assets/images/logo.png',
                height: 250,
                width: double.infinity,
              ),
              Text(
                'Brand New Kicks',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.teal.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Custom sneakers made with premium quality directly to your door.",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 90),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Container(
                  height: 70,
                  width: 180,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade700,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Center(
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
