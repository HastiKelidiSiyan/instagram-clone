import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SignupHead(), body: SignupBody());
  }
}

class SignupHead extends StatelessWidget implements PreferredSizeWidget {
  const SignupHead({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 102,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: SizedBox(
        height: 102,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/images/backButton.png",
                    height: 32,
                    width: 32,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  "Create Your Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(102);
}

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: SignupFormWithButtons(),
    );
  }
}

class SignupFormWithButtons extends StatefulWidget {
  const SignupFormWithButtons({super.key});

  @override
  State<SignupFormWithButtons> createState() => _SignupFormWithButtonsState();
}

class _SignupFormWithButtonsState extends State<SignupFormWithButtons> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  String? selectedCountry;
  int? _radioGroupValue;
  bool _switchValue = true;
  bool _checkboxValue = false;

  String? _nameError;
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _countryError;
  String? _genderError;

  final List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
    'India',
    'China',
  ];

  void _validateName() {
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = "Full Name cannot be empty";
      });
    } else {
      setState(() {
        _nameError = null;
      });
    }
  }

  void _validateUsername() {
    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        _usernameError = "Username cannot be empty";
      });
    } else {
      setState(() {
        _usernameError = null;
      });
    }
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _emailError = "Email cannot be empty";
      });
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailError = "Please enter a valid email address";
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validatePassword() {
    final password = _passwordController.text;

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password cannot be empty";
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _passwordError = "Password must be at least 6 characters long";
      });
      return;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        _passwordError = "Include at least 1 uppercase letter";
      });
      return;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      setState(() {
        _passwordError = "Include at least 1 lowercase letter";
      });
      return;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      setState(() {
        _passwordError = "Include at least 1 number";
      });
      return;
    }

    setState(() {
      _passwordError = null;
    });
  }

  void _validateCountry() {
    if (selectedCountry == null) {
      setState(() {
        _countryError = "Please select a country";
      });
    } else {
      setState(() {
        _countryError = null;
      });
    }
  }

  void _validateGender() {
    if (_radioGroupValue == null) {
      setState(() {
        _genderError = "Please select a gender";
      });
    } else {
      setState(() {
        _genderError = null;
      });
    }
  }

  bool get _isFormValid {
    return _nameError == null &&
        _usernameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _countryError == null &&
        _genderError == null &&
        _nameController.text.trim().isNotEmpty &&
        _usernameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        selectedCountry != null &&
        _radioGroupValue != null &&
        _checkboxValue;
  }

  void _submitForm() async {
    _validateName();
    _validateUsername();
    _validateEmail();
    _validatePassword();
    _validateCountry();
    _validateGender();

    if (_isFormValid) {
      var newId = (await UserRepository().getUsers()).length + 1;
      UserModel user = UserModel(
        userId: newId,
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        avatar: 'https://images.unsplash.    photo-150268510422    32379fefbe',
        bio: "",
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text.trim());
      await prefs.setString('password', _passwordController.text.trim());
      UserRepository().addUser(user);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Name Field
          AnimatedContainer(
            height: _nameError != null ? 69 : 48,
            duration: Duration(milliseconds: 200),
            width: 315,
            child: TextField(
              controller: _nameController,
              onChanged: (value) => _validateName(),
              decoration: InputDecoration(
                hintText: "Full Name",
                errorText: _nameError,
                errorStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _nameError != null ? Colors.red : Color(0xFFDBDBDB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _nameError != null ? Colors.red : Color(0xFF3897F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Username Field
          AnimatedContainer(
            height: _usernameError != null ? 69 : 48,
            duration: Duration(milliseconds: 200),
            width: 315,
            child: TextField(
              controller: _usernameController,
              onChanged: (value) => _validateUsername(),
              decoration: InputDecoration(
                hintText: "Username",
                errorText: _usernameError,
                errorStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _usernameError != null
                        ? Colors.red
                        : Color(0xFFDBDBDB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _usernameError != null
                        ? Colors.red
                        : Color(0xFF3897F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Email Field
          AnimatedContainer(
            height: _emailError != null ? 69 : 48,
            duration: Duration(milliseconds: 200),
            width: 315,
            child: TextField(
              controller: _emailController,
              onChanged: (value) => _validateEmail(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                errorText: _emailError,
                errorStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _emailError != null ? Colors.red : Color(0xFFDBDBDB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _emailError != null ? Colors.red : Color(0xFF3897F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Password Field
          AnimatedContainer(
            height: _passwordError != null ? 69 : 48,
            duration: Duration(milliseconds: 200),
            width: 315,
            child: TextField(
              controller: _passwordController,
              onChanged: (value) => _validatePassword(),
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: "Password",
                errorText: _passwordError,
                errorStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordError != null
                        ? Colors.red
                        : Color(0xFFDBDBDB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordError != null
                        ? Colors.red
                        : Color(0xFF3897F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/images/visibilityIcon.png"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Country Field
          AnimatedContainer(
            height: _countryError != null ? 69 : 48,
            duration: Duration(milliseconds: 200),
            width: 315,
            child: DropdownButtonFormField<String>(
              initialValue: selectedCountry,
              decoration: InputDecoration(
                hintText: "Country/Region",
                errorText: _countryError,
                errorStyle: TextStyle(fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _countryError != null
                        ? Colors.red
                        : Color(0xFFDBDBDB),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _countryError != null
                        ? Colors.red
                        : Color(0xFF3897F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 16,
                ),
              ),
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/images/dropDownButton.png",
                  height: 16,
                  width: 16,
                ),
              ),
              items: countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(
                    country,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                  _validateCountry();
                });
              },
            ),
          ),
          SizedBox(height: 16),

          // Gender Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _genderError != null ? Colors.red : Colors.black,
                    ),
                  ),
                  if (_genderError != null) ...[
                    SizedBox(width: 8),
                    Text(
                      _genderError!,
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          value: 1,
                          groupValue: _radioGroupValue,
                          onChanged: (value) {
                            setState(() {
                              _radioGroupValue = value;
                              _validateGender();
                            });
                          },
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xFF3897F0);
                            }
                            return Color(0xFF8E8E8E);
                          }),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("Male"),
                    ],
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          value: 2,
                          groupValue: _radioGroupValue,
                          onChanged: (value) {
                            setState(() {
                              _radioGroupValue = value;
                              _validateGender();
                            });
                          },
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xFF3897F0);
                            }
                            return Color(0xFF8E8E8E);
                          }),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("Female"),
                    ],
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Radio(
                          value: 3,
                          groupValue: _radioGroupValue,
                          onChanged: (value) {
                            setState(() {
                              _radioGroupValue = value;
                              _validateGender();
                            });
                          },
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xFF3897F0);
                            }
                            return Color(0xFF8E8E8E);
                          }),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("Other"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Notifications Switch
          SizedBox(
            height: 47,
            width: 315,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Receive Notifications",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(
                  height: 31,
                  width: 51,
                  child: Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                    activeThumbColor: Color(0xFFFFFFFF),
                    activeTrackColor: Color(0xFF3897F0),
                    inactiveThumbColor: Color(0xFFFFFFFF),
                    inactiveTrackColor: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Terms & Conditions Checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Checkbox(
                  value: _checkboxValue,
                  onChanged: (value) {
                    setState(() {
                      _checkboxValue = value!;
                    });
                  },
                  side: BorderSide(width: 2, color: Color(0xFF8E8E8E)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Color(0xFF3897F0);
                    }
                    return Color(0xFFFFFFFF);
                  }),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "I agree to the Terms & Conditions",
                style: TextStyle(fontSize: 12, color: Color(0xFF8E8E8E)),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Sign Up Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fixedSize: Size(315, 48),
              backgroundColor: _isFormValid
                  ? Color(0xFF3897F0)
                  : Color(0xFF3897F0),
            ),
            onPressed: _isFormValid ? _submitForm : null,
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Login Link
          SizedBox(
            height: 57,
            width: 315,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 14, color: Color(0xFF8E8E8E)),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3897F0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
