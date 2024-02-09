import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/course_lessons.dart';
import 'package:flutter_application_1/Services/login.dart';
import 'package:flutter_application_1/Services/user_courses.dart';
import 'package:flutter_application_1/course_lessons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesPage extends StatelessWidget {

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
          child: FutureBuilder<String>(
              future: getUserId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return FutureBuilder<List<Course>>(
              future: fetchCourses('48230'), // Replace '48230' with the actual user ID
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: <Widget>[
                      Image.network(snapshot.data![index].image, width: 250,),
                      SizedBox(height: 15),
                      Text(snapshot.data![index].name, style: TextStyle(fontSize: 20)),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String? userId = prefs.getString('userId');
                            if (userId != null) {
                              List<int> userCourses = await fetchUserCourses(userId);
                              if (userCourses.contains(int.parse(snapshot.data![index].id))) {
                                // Fetch the course data and navigate to the new page
                                var courseData = await fetchCourseData(snapshot.data![index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonsPage(lessons: courseData,),
                                  ),
                                );
                              } else {
                                // Show an error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('لست مشترك في هذه الدورة')),
                                );
                              }
                            } else {
                              // Handle the case where the user ID is not found in shared preferences
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('User ID not found')),
                              );
                            }
                          },
                        child: Text('اختر', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // This is the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // This makes the button corners have zero radius
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * .3, // This makes the button have the full width of the page
                            50, // This is the height of the button
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                );
              },
            );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            );
                  }
                }
              },
            )
        ),
      ),
    );
  }
}
