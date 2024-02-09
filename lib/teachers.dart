import 'package:flutter/material.dart';
import 'package:flutter_application_1/courses.dart';

class TeachersPage extends StatelessWidget {
  final List<Teacher> teachers = [
    Teacher(image: 'assets/images2/man2.png', name: 'أ . همام المنشاوي 2006 ف1'),
    Teacher(image: 'assets/images2/man2.png', name: 'أ . همام المنشاوي 2006 ف1'),
    Teacher(image: 'assets/images2/man2.png', name: 'أ . همام المنشاوي 2006 ف1'),
    // Add more teachers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers Page'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(teachers[index].image, width: 100, height: 100),
                  SizedBox(height: 20),
                  Text(teachers[index].name),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50, // Set your desired height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Set the background color to blue
                        onPrimary: Colors.white, // Set the text color to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Set border radius to zero
                        ),
                      ),
                      onPressed: () {
                        // Handle choose button press here
                        // Handle button 1 press here
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoursesPage()),
      );
                      },
                      child: Text('Choose'),
                    ),
                  ),
                              SizedBox(height: 40), // Add a SizedBox with height 40px here

                ],
                
              );
              
            },
          ),
        ),
      ),
    );
  }
}

class Teacher {
  final String image;
  final String name;

  Teacher({required this.image, required this.name});
}