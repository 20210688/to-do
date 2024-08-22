
import 'package:flutter/material.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/login/login.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  static const String routName = "SignUp";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final  TextEditingController _ageController = TextEditingController();

  String _errorMessage = '';

  void _signUp() {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
   // final age =_ageController.text;
    int? age;
    try {
      age = int.parse(_ageController.text);
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid age input';
      });
      return;
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: "I have an Account? "),
                TextSpan(
                  text: "Login",
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
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'age'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp();
                  }
                  FirebaseFunctions.createAccountAuth(_emailController.text,
                      _passwordController.text,
                  age: int.parse(_ageController.text),
                  phone: _phoneController.text,
                  userName: _usernameController.text,
                  onSuccess: (){
                    Navigator.pushNamed(context,LoginScreen.routName);
                  },
                    onError: (error){
                    showDialog(context: context,
                        builder:(context)=>AlertDialog(
                          title: Text("Error",style:TextStyle(color:Colors.black,fontSize: 30,
                          fontWeight: FontWeight.w500) ,),
                          content: Text("enter email or password",style:TextStyle(color:Colors.red,
                            fontSize: 16,fontWeight: FontWeight.normal,
                          ),),

                          actions: [
                            ElevatedButton(onPressed:(){
                              Navigator.pop(context);
                            }, child:Text("Cancel")),
                            ElevatedButton(onPressed:(){
                              Navigator.pop(context);
                            }, child:Text("Ok")),
                          ],
                        )
                    );
                    }
                  );
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
