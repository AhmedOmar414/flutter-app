import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/login.dart';
import 'package:flutter_application_1/courses.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/teachers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.3, // 30% of the screen width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Hello User Text
              FutureBuilder<String>(
                  future: getUsername(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show a loading spinner while waiting
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          ' ${snapshot.data}, مرحبا بك',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      }
                    }
                  },
                ),
            
              SizedBox(height: 20),
              // Button 1
              Container(
                height: 60.0, // This is the height of the button. Adjust this value as needed.
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue),
                    backgroundColor: const Color.fromARGB(255, 241, 240, 240),
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // This is the button radius
                    ),
                  ),
                  onPressed: () {
                    // Handle button 1 press here
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoursesPage()),
                         );
                  },
                  child: Text('دوراتي',style: TextStyle(fontSize: 22)),
                ),
              ),
              SizedBox(height: 20),
              // Button 2
              Container(
                  height: 60.0, // This is the height of the button. Adjust this value as needed.
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue),
                    backgroundColor: const Color.fromARGB(255, 241, 240, 240),
                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // This is the button radius
                    ),
                  ),
                  onPressed: () {
                    // Handle button 2 press here
                  },
                  child: Text('تواصل معنا', style: TextStyle(fontSize: 22),),
                ),
              ),
              SizedBox(height: 20),
              // Logout Button
              Container(
                height: 60.0,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue),
                    backgroundColor: const Color.fromARGB(255, 241, 240, 240),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () async {
                    await logout();
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                  },
                  child: Text('Logout', style: TextStyle(fontSize: 22),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}