import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/core/widgets/my_textfield.dart';
import 'package:sneaker_app/features/cart/providers/auth_provider.dart';
import 'package:sneaker_app/features/shop/pages/home_page.dart';

import 'package:sneaker_app/features/shop/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUserIn() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // call the login function and wait for the result
    final errorMessage = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      body: SingleChildScrollView(
        physics: isKeyboardOpen
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 60),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Getting Started, Welcome Back",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              MyTextfield(
                controller: _emailController,
                hint: 'Enter your Email',
                fillColor: Colors.white,
                filled: true,
                hintColor: Colors.black,
                textColor: Colors.black,
                prefixIcon: Icon(Icons.email),
              ),
              SizedBox(height: 20),
              MyTextfield(
                controller: _passwordController,
                hint: 'Password',
                fillColor: Colors.white,
                filled: true,
                hintColor: Colors.black,
                textColor: Colors.black,
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: signUserIn,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.teal.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
