import 'package:flutter/material.dart';
import 'package:flutter_application_1/teachers.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.3, // 30% of the screen width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Hello User Text
              Text(
                'Hello, User Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      MaterialPageRoute(builder: (context) => TeachersPage()),
      );
                  },
                  child: Text('الموادالدراسية',style: TextStyle(fontSize: 22)),
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
            ],
          ),
        ),
      ),
    );
  }
}