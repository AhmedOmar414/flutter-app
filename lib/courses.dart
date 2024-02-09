import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  final List<Lesson> lessons = [
    Lesson(image: 'assets/images2/student.jpg', name: 'كيف احفظ يا استاذ همام'),
    Lesson(image: 'assets/images2/student.jpg', name: 'كيف احفظ يا استاذ همام'),
    Lesson(image: 'assets/images2/student.jpg', name: 'كيف احفظ يا استاذ همام'),
    // Add more lessons as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('الدورات')),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(lessons[index].image, width: 250, height: 250),
                  SizedBox(height: 20),
                  Text(lessons[index].name),
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
                      },
                      child: Text('اختر'),
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

class Lesson {
  final String image;
  final String name;

  Lesson({required this.image, required this.name});
}