import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';


Future<Map<String, dynamic>> loginUser(String username, String password) async {
  // Encode the username and password in Base64
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

  // Make the HTTP request...
  var response = await http.get(
    Uri.parse('https://al-maher.net/ar/demo_rest_api/demo_resource?_format=json&code=1183118037061&pid=66&time=1601118153&flags=login'),
    // Send the authorization headers
    headers: <String, String>{'authorization': basicAuth},
  );
  // Parse the JSON response
  var jsonResponse = jsonDecode(response.body);
  print('Response: $jsonResponse');
  // Return the whole jsonResponse object
  return jsonResponse;
}