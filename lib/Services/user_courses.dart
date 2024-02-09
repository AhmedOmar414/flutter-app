import 'package:http/http.dart' as http;
import 'dart:convert';

class Course {
  final String id;
  final String name;
  final String image;

  Course({required this.id, required this.name, required this.image});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['tax_tid'],
      name: json['tax_name'],
      image: json['tax_image'],
    );
  }
}

Future<List<Course>> fetchCourses(String userId) async {
  final response = await http.get(Uri.parse('https://al-maher.net/api/get_myCourse.php?tid=$userId&time=1693943375'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['rows'];
    return jsonResponse.map((item) => Course.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<int>> fetchUserCourses(String userId) async {
  var response = await http.get(Uri.parse('https://al-maher.net/api/get_auth_course.php?user_id=$userId'));
  var jsonResponse = jsonDecode(response.body);
  
  // Check if 'rows' key exists in the response
  if (jsonResponse != null && jsonResponse.containsKey('rows')) {
    List<dynamic> rows = jsonResponse['rows'];
    return rows.map((item) => int.parse(item['tid'])).toList();
  } else {
    // Return an empty list if 'rows' key does not exist
    return [];
  }
}