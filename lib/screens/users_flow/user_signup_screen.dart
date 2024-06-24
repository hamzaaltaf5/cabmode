import 'package:cabmode/resources/auth_methods.dart';
import 'package:cabmode/resources/local_methods/utils.dart';
import 'package:cabmode/screens/users_flow/user_homepage_screen.dart';
import 'package:flutter/material.dart';

class UserSignUpScreen extends StatefulWidget {
  @override
  _UserSignUpScreenState createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController =
  TextEditingController();
  bool isLoading = false;

  void registerUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNumber: int.parse(_phoneNumberController.text),
    );

    setState(() {
      isLoading = false;
    });

    if(res != 'success'){
      showSnackBar(context, res);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: registerUser,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Text('Register User'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
