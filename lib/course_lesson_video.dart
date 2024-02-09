import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/course_lessons.dart';
import 'package:flutter_application_1/lesson_subject.dart';
import 'package:url_launcher/url_launcher.dart';
class CourseLessonVideo extends StatelessWidget {
  final List<Lesson> lessons;

  CourseLessonVideo({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images2/class_select.jpg', // Replace with your static image URL
                  width: 200,
                ),
                Text(lessons[index].name, style: TextStyle(fontSize: 20)),
                SizedBox(height: 15),
                ElevatedButton(
                 onPressed: () async {
                        List<Lesson> subjects = await fetchSubjectData(lessons[index].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubjectPage(subjects: subjects),
                          ),
                        );
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
                SizedBox(height: 35),
                if (lessons[index].external_link != null)
                      ElevatedButton(
                        onPressed: () async {
                          if (await canLaunch(lessons[index].external_link!)) {
                            await launch(lessons[index].external_link!);
                          } else {
                            throw 'Could not launch ${lessons[index].external_link}';
                          }
                        },
                        child: Text('Open External Link', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // This is the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // This makes the button corners have zero radius
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * .3, // This makes the button have the full width of the page
                            50, // This is the height of the button
                          ),
                        ),
                      ),

                // Add more widgets to display other lesson data...
              ],
            ),
          );
        },
      ),
    );
  }
}