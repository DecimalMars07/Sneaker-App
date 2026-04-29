import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_app/core/widgets/my_textfield.dart';
import 'package:sneaker_app/features/cart/providers/auth_provider.dart';
import 'package:sneaker_app/features/shop/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  void signUserUp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // call the login function and wait for the result
    final errorMessage = await authProvider.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _userNameController.text.trim(),
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
              SizedBox(height: 50),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Getting Started, Welcome Back",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              MyTextfield(
                controller: _userNameController,
                hint: 'UserName',
                fillColor: Colors.white,
                filled: true,
                hintColor: Colors.black,
                textColor: Colors.black,
                prefixIcon: Icon(Icons.person),
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
                    "Already have an account?",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: signUserUp,
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
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.teal.shade900,
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
