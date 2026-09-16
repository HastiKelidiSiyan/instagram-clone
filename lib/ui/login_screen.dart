// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:instagram_clone/ui/app_icon.dart';
// import 'package:instagram_clone/ui/loading_screen.dart';
// import 'package:instagram_clone/ui/signup_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   bool _checkboxValue = false;

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;

//   void _validateUsername() {
//     final username = _usernameController.text.trim();
//     if (username.isEmpty) {
//       setState(() {
//         _usernameError = "Username cannot be empty";
//       });
//     } else {
//       setState(() {
//         _usernameError = null;
//       });
//     }
//   }

//   void _validatePassword() {
//     final password = _passwordController.text.trim();
//     if (password.isEmpty) {
//       setState(() {
//         _passwordError = "Password cannot be empty";
//       });
//     } else {
//       setState(() {
//         _passwordError = null;
//       });
//     }
//   }

//   bool get _isFormValid {
//     return _usernameError == null &&
//         _passwordError == null &&
//         _usernameController.text.trim().isNotEmpty &&
//         _passwordController.text.trim().isNotEmpty;
//   }

  // Future<bool> _isUserValid(String username, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? storedUsername = prefs.getString('username');
  //   String? storedPassword = prefs.getString('password');

  //   return storedUsername == username && storedPassword == password;
  // }

//   void _submitForm() async {
//     String password = _passwordController.text.trim();
//     String username = _usernameController.text.trim();

//     if (_isFormValid) {
//       bool isUservalid = await _isUserValid(username, password);
//       if (isUservalid) {
//         Get.off(() => const LoadingScreen());
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Invalid username or password"),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _loginBody(),
//     );
//   }

//   Widget _loginBody() {
//     return Padding(
//       padding: EdgeInsets.all(30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _loginLogo(),
//           _loginForms(),
//           _customeDivider(),
//           _bottomSection(),
//         ],
//       ),
//     );
//   }

//   Widget _loginLogo() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30),
//       child: SizedBox(
//         height: 135,
//         width: 315,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/images/InstagramIcon.png",
//               height: 49,
//               width: 49,
//             ),
//             SizedBox(height: 6),
//             AppIcon(
//               asset: "assets/images/InstagramLogo.png",
//               height: 49,
//               width: 182,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loginForms() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: SizedBox(
//         width: 315,
//         child: Column(
//           children: [
//             AnimatedContainer(
//               height: _usernameError != null ? 69 : 48,
//               duration: Duration(milliseconds: 200),
//               width: 315,
//               child: TextField(
//                 controller: _usernameController,
//                 onChanged: (value) => _validateUsername(),
//                 decoration: InputDecoration(
//                   hintText: "Username or Email",
//                   errorText: _usernameError,
//                   errorStyle: TextStyle(fontSize: 12),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _usernameError != null
//                           ? Colors.red
//                           : Color(0xFFDBDBDB),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _usernameError != null
//                           ? Colors.red
//                           : Color(0xFF3897F0),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red, width: 1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red, width: 2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             AnimatedContainer(
//               height: _passwordError != null ? 69 : 48,
//               duration: Duration(milliseconds: 200),
//               width: 315,
//               child: TextField(
//                 controller: _passwordController,
//                 onChanged: (value) => _validatePassword(),
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   errorText: _passwordError,
//                   errorStyle: TextStyle(fontSize: 12),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _passwordError != null
//                           ? Colors.red
//                           : Color(0xFFDBDBDB),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: _passwordError != null
//                           ? Colors.red
//                           : Color(0xFF3897F0),
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red, width: 1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red, width: 2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                     icon: SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: AppIcon(
//                         asset: "assets/images/visibilityIcon.png",
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: Checkbox(
//                     value: _checkboxValue,
//                     onChanged: (value) {
//                       setState(() {
//                         _checkboxValue = value!;
//                       });
//                     },
//                     side: BorderSide(width: 2, color: Color(0xFF8E8E8E)),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                     fillColor: WidgetStateProperty.resolveWith<Color>((
//                       states,
//                     ) {
//                       if (states.contains(WidgetState.selected)) {
//                         return Color(0xFF3897F0);
//                       }
//                       return Theme.of(context).colorScheme.surface;
//                     }),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Text("Remember Me"),
//               ],
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 fixedSize: Size(315, 48),
//                 backgroundColor: _isFormValid
//                     ? Color(0xFF3897F0)
//                     : Color(0xFF3897F0),
//               ),
//               onPressed: _isFormValid ? _submitForm : null,
//               child: Text(
//                 "Login",
//                 style: TextStyle(
//                   color: Color(0xFFFFFFFF),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Forgot Password?",
//               style: TextStyle(fontSize: 14, color: Color(0xFF3897F0)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _customeDivider() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 30),
//       child: SizedBox(
//         height: 56,
//         width: 315,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   height: 1,
//                   width: 136,
//                   color: Color(0xFFDBDBDB),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text(
//                     "OR",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF8E8E8E),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   width: 136,
//                   color: Color(0xFFDBDBDB),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _bottomSection() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: SizedBox(
//         height: 41,
//         width: 315,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Don't have an account?",
//               style: TextStyle(fontSize: 14, color: Color(0xFF8E8E8E)),
//             ),
//             SizedBox(width: 8),
//             InkWell(
//               onTap: () {
//                 Get.to(() => SignupScreen());
//               },
//               child: Text(
//                 "Register",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF3897F0),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
