import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/user_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  final _userNameController = TextEditingController();
  final _userFullNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
final _userConfirmPasswordController = TextEditingController();

  bool isPasswordConfirmed() {
  return _userPasswordController.text == _userConfirmPasswordController.text;
}
Future<void> saveUserId(String userId,String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId'); // Remove the existing user id
    await prefs.remove('username'); // Remove the existing user id


  await prefs.setString('userId', userId); // Save the new user id
    await prefs.setString('username', username); // Save the new user id

}
Future<void> signUp(String userName, String userEmail, String userFullName, String userPhone, String userPassword) async {
  final response = await http.get(
    Uri.parse('https://al-maher.net/ar/demo_rest_api/demo_resource?_format=json&code=1183118037061&pid=66&flags=register&userName=$userName&userEmail=$userEmail&userFullName=$userFullName&userPhone=$userPhone&userPassword=$userPassword&time=1695671655'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 'emailUsed') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('البريد الإلكتروني مستخدم بالفعل')),
      );
    } else if(jsonResponse['status'] == 'usernameUsed') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('اسم المستخدم مستخدم بالفعل')),
      );
    }
    else if (jsonResponse['status'] == 'register-done') {
      saveUserId(jsonResponse['user_id'],jsonResponse['userName']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  } else {
    // If the server returns an unexpected response, print the status code and body, then throw an error.
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to register user');
  }
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100,bottom: 20),
          child: Center(
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 1.25,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromARGB(255, 192, 192, 192), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images2/1024.png',
                      width: 250.0,
                    ),
                   Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _userNameController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'اسم المستخدم',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
),

// Repeat this for each TextField
                    SizedBox(height: 20),
                  Stack(
                      alignment: Alignment.center,
                      children: [
                        TextField(
                          controller: _userEmailController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Positioned(
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white,
                            child: Text(
                              'البريد الالكتروني',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                      SizedBox(height: 20),
                   Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _userPhoneController,
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'رقم الهاتف',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
                   Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _userFullNameController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'الاسم الكامل',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),

                   Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _userPasswordController,
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'كلمة المرور',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: _userConfirmPasswordController,
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'تأكيد كلمة المرور',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
                    SizedBox(height: 20),
                    Container(
                      height: 45.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                              if (isPasswordConfirmed()) {
                                signUp(
                                  _userNameController.text,
                                  _userEmailController.text,
                                  _userFullNameController.text,
                                  _userPhoneController.text,
                                  _userPasswordController.text

                                );
                              } else {
                                // Show an error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('كلمات المرور غير متطابقة')),
                                );
                              }
                            },
                        child: Text(
                          'تسجيل',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}