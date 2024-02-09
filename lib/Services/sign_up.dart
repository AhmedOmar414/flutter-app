
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> signUp(String userName, String userEmail, String userPassword, String userFullName, String userPhone) async {
  final response = await http.post(
    Uri.parse('https://al-maher.net/ar/demo_rest_api/demo_resource?_format=json&code=1183118037061&pid=66&flags=register&userPassword=$userPassword&userEmail=$userEmail&userName=$userName&userFullName=$userFullName&userPhone=$userPhone&time=1695671655'),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    print('User registered successfully');
  } else {
    // If the server returns an unexpected response, throw an error.
    throw Exception('Failed to register user');
  }
}