import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/login.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:flutter_application_1/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    Future<void> saveUserData(Map<String, dynamic> data) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', data['user_id']);
      await prefs.setString('username', data['userName']);
    }
  ValueNotifier<bool> _obscureText = ValueNotifier(true);

   void _togglePasswordVisibility() {
    _obscureText.value = !_obscureText.value;
  }
      // Create the TextEditingController objects
      final usernameController = TextEditingController();
      final passwordController = TextEditingController();
  Future<Map<String, dynamic>>? loginResult;

  // showAlert function
  Future<void> showAlert(BuildContext context, String title, String message) async {
  await Future.delayed(Duration.zero);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.4, // 50% of the screen width
          height:screenHeight * 0.8,
          decoration: BoxDecoration(
            color: Colors.white, // This sets the background color of the container
            border: Border.all(color: Color.fromARGB(255, 192, 192, 192), width: 2), // This adds the border
            borderRadius: BorderRadius.circular(10), // This sets the border radius to 10
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Login title
              Image.asset(
                'assets/images2/1024.png',
                width: 250.0, // You can adjust the width as needed
              ),
          
              // Email TextField
             Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: usernameController,
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
              SizedBox(height: 20),
              // Password TextField
               ValueListenableBuilder<bool>(
                      valueListenable: _obscureText,
                      builder: (context, value, child) {
                        return Stack(
  alignment: Alignment.center,
  children: [
    TextField(
      controller: passwordController,
      textAlign: TextAlign.center,
      obscureText: value,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            value ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      textDirection: TextDirection.rtl,
    ),
    Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Text(
          'الرقم السري',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  ],
);
                      },
                    ),
              SizedBox(height: 20),
              // Login Button
                Container(
                  height: 45.0, // This is the height of the button. Adjust this value to match the height of your text fields.
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // This is the button color
                       shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // This removes the border radius
                            ),
                    ),
                    onPressed: () {
                            setState(() {
                               loginResult = loginUser(usernameController.text, passwordController.text);
                        
                              });                 
                           },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white), // This is the text color
                    ),
                  ),
                ),
              
                SizedBox(height: 15),
                 Container(
                  height: 45.0, // This is the height of the button. Adjust this value to match the height of your text fields.
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                       // This is the button color
                       shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5), // This removes the border radius
                            ),
                            ),
                    onPressed: () {
                      // Navigate to UserProfileScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                    },
                    child: const Text(
                      'انشاء حساب',
                      style: TextStyle(color: Colors.white), // This is the text color
                    ),
                  ),
                ),
              FutureBuilder<Map<String, dynamic>>(
                    future: loginResult,
                    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading spinner
                      } else {
                        if (snapshot.hasError) {
                          showAlert(context, "Error", "An error occurred during login.");
                        } else if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!['status'] == 'login-sucess') {
                              saveUserData(snapshot.data!);
                               WidgetsBinding.instance!.addPostFrameCallback((_) {
                                   Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Home()),
                                  );
                                });
                          
                            } else if (snapshot.data!['status'] == 'login-faild') {
                            showAlert(context, "فشل", "تأكد من بياناتك مجداا.");
                          }
                        }
                        return Container(); // Return an empty container when not loading
                      }
                    },
                  ),
            ],
            
          ),
          ),
        ),
      ),
    );
  }
}