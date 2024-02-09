import 'dart:convert';
import 'package:http/http.dart' as http;

class SliderService {
  Future<List<SliderItem>> fetchSliders() async {
    final response = await http.get(Uri.parse('http://al-maher.net/api/get_slider.php'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<SliderItem> sliders = [];
      for (var item in jsonData['rows']) {
        sliders.add(SliderItem.fromJson(item));
      }
      return sliders;
    } else {
      throw Exception('Failed to load sliders');
    }
  }
}

class SliderItem {
  final String title;
  final String image;
  final String body;

  SliderItem({required this.title, required this.image, required this.body});

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      title: json['title'],
      image: json['field_slider_image'],
      body: json['body'],
    );
  }
}