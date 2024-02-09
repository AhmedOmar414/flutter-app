import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/course_lessons.dart';
import 'package:flutter_application_1/video.dart';
class SubjectPage extends StatelessWidget {
  final List<Lesson> subjects;

  SubjectPage({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images2/class_select.jpg',
                  width: 200,
                ),
                Text(subjects[index].name, style: TextStyle(fontSize: 20)),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                      try {
                        var videoData = await fetchLessonVideo(subjects[index].id);
                        print(videoData.youtub);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPage(videoData)),
                        );
                      } catch (e) {
                        print('Failed to load video: $e');
                      }
                    },
                  child: Text('شغل الفيديو', style: TextStyle(color: Colors.white)),
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
                // Add more widgets to display other subject data...
              ],
            ),
          );
        },
      ),
    );
  }
}