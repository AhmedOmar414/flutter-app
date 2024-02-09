import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/course_lessons.dart';
import 'package:flutter_application_1/course_lesson_video.dart';

class LessonsPage extends StatelessWidget {
  final List<Lesson> lessons;

  LessonsPage({required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
         width: MediaQuery.of(context).size.width * 0.3,
        child: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return  Column(
              children: <Widget>[
                Image.asset(
                  'assets/images2/class_select.jpg',// Replace with your static image URL
                  width: 200,
                ),
                SizedBox(height: 20),

                Text(lessons[index].name,style: TextStyle(fontSize: 20),),
                SizedBox(height: 15),
                ElevatedButton(
                      onPressed: () async {
                        List<Lesson> lessonData = await fetchLessonData(lessons[index].id);
                        print(lessonData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseLessonVideo(lessons: lessonData),
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

              ],
            );
         
        },
      ),
        ),
      ),
    );
  }
}