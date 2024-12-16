import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_unsplash/model/photo.dart';

class API {
  static const String baseUrl = 'https://picsum.photos/v2';

  static Future<List<Photo>> getRandomPhotos({int count = 30}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list'),
    );

    if (response.statusCode == 200) {
      List<dynamic> resBody = jsonDecode(response.body);
      if (kDebugMode) {
        print(resBody);
      }
      return resBody.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}