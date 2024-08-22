import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/homescreen.dart';
import 'package:to_do/login/SignUp.dart';
import 'package:to_do/providers/my_provider.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  static const String routName = "Login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;


  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SignUpScreen.routName);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: "Don't have an Account? "),
                TextSpan(
                  text: "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFunctions.LoginUser(
                      _emailController.text,
                      _passwordController.text,
                      onSuccess: (label) {
                        provider.initUser();
                       Navigator.pushNamedAndRemoveUntil
                         (context,HomeScreen.routName, (route) => false,
                          arguments: label,
                        );
                      },
                      onError: (error) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(error), // Show actual error
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Okay!!"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


