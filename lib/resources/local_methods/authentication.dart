// signUpAdmin() async {
//   setState(() {
//     _isloading = true;
//   });
//
//   String res = await AuthMethods().signUpAdmin(
//     name: _nameController.text,
//     email: _emailController.text,
//     password: _passwordController.text,
//   );
//
//   setState(() {
//     _isloading = false;
//   });
//
//   if (res != 'success') {
//     showSnackBar(context, res);
//   } else {
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => AdminPageScreen()));
//   }
// }
//
//
// Sign Up Driver
// // void signUpDriver() async {
//   setState(() {
//     _isloading = true;
//   });
//   String res = await AuthMethods().signUpDriver(
//     email: _emailController.text,
//     password: _passwordController.text,
//   );
//
//   setState(() {
//     _isloading = false;
//   });
//
//   if (res != 'success') {
//     showSnackBar(context, res);
//   } else {
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => AdminPageScreen()));
//   }
// }