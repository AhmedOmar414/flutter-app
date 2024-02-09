import 'package:http/http.dart' as http;
import 'dart:convert';

class Lesson {
  final String id;
  final String name;
   final String? external_link;


  Lesson({required this.id, required this.name,this.external_link,});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['tax_tid'],
      name: json['tax_name'],
      external_link: json['external_link'],

    );
  }

  @override
  String toString() {
    return 'Lesson{id: $id, name: $name}';
  }
}
Future<List<Lesson>> fetchCourseData(String courseId) async {
  
  var response = await http.get(Uri.parse('https://al-maher.net/api/get_level1_data_ids.php?tid=$courseId&time=1693943375'));
  var jsonResponse = jsonDecode(response.body);
  return List<Lesson>.from(jsonResponse['rows'].map((item) => Lesson.fromJson(item)));
}

Future<List<Lesson>> fetchLessonData(String lessonId) async {
  var response = await http.get(Uri.parse('https://al-maher.net/api/get_level1_data_ids.php?tid=$lessonId&time=1693943375'));
  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse);  // Add this line
  if (jsonResponse != null && jsonResponse.containsKey('rows')) {
    return jsonResponse['rows'].map<Lesson>((item) => Lesson.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load lesson data');
  }
}

Future<List<Lesson>> fetchSubjectData(String lessonId) async {
  var response = await http.get(Uri.parse('https://al-maher.net/api/get_lesson.php?tid=$lessonId&time=1693943375'));
  var jsonResponse = jsonDecode(response.body);
  
  print(jsonResponse);  // Add this line
  
  if (jsonResponse != null && jsonResponse.containsKey('rows')) {
    var rows = jsonResponse['rows'];
    if (rows is List) {
      return rows.map<Lesson>((item) => Lesson.fromJson(item)).toList();
    } else {
      throw Exception('Rows is not a list');
    }
  } else {
    throw Exception('Failed to load subject data');
  }
}


class LessonVideo {
  final String tax_name;
  final String tax_tid;
  final String youtub;
  final String dyntub;
  final String viemo;

  LessonVideo({
    required this.tax_name,
    required this.tax_tid,
    required this.youtub,
    required this.dyntub,
    required this.viemo,
  });

  factory LessonVideo.fromJson(Map<String, dynamic> json) {
    return LessonVideo(
      tax_name: json['tax_name'],
      tax_tid: json['tax_tid'],
      youtub: json['youtub'],
      dyntub: json['dyntub'],
      viemo: json['viemo'],
    );
  }
  @override
  String toString() {
    return 'LessonVideo { tax_name: $tax_name, tax_tid: $tax_tid, youtub: $youtub, dyntub: $dyntub, viemo: $viemo }';
  }
}

Future<LessonVideo> fetchLessonVideo(String tid) async {
  var response = await http.get(Uri.parse('https://al-maher.net/api/get_lesson_data.php?tid=$tid&time=1693943375'));
  var jsonResponse = jsonDecode(response.body);
  
  if (jsonResponse != null && jsonResponse.containsKey('rows')) {
    var rows = jsonResponse['rows'];
    if (rows is List && rows.isNotEmpty) {
      return LessonVideo.fromJson(rows[0]);
    } else {
      throw Exception('Rows is empty or not a list');
    }
  } else {
    throw Exception('Failed to load lesson video');
  }
}