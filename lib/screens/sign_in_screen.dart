import 'package:cabmode/resources/auth_methods.dart';
import 'package:cabmode/screens/driver_flow/driver_homepage_screen.dart';

import 'admin_flow/admin_homepage_screen.dart';
import 'package:flutter/material.dart';
import '../screens/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signInMethod() {
    //BuildContext context;
    bool isValid;
    isValid = _formKey.currentState!.validate();

    if (isValid) {
      AuthMethods().signInAdmin(email: _emailController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Success')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DriverHomePageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                Text(
                  'Cabmode!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      fontFamily: 'times new roman',
                      color: Colors.indigo),
                ),

                SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    TextButton(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'Email',
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Password',
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () {},
                  ),
                ),

                //SizedBox(height: 20.0,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                    child: Text('LOGIN'),
                    onPressed: _signInMethod,
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      'or',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),

                Container(
                  color: Colors.blue.shade900,
                  child: ListTile(
                    leading: SizedBox(
                      width: 50.0,
                      child: Icon(
                        Icons.facebook,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Sign up with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 10.0,),

                Container(
                  color: Colors.blue,
                  child: ListTile(
                    leading: SizedBox(
                      width: 50.0,
                      child: Icon(
                        Icons.title,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Sign up with Twitter',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
