// lib/repositories/movie_api.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/movies_model.dart';


class ApiService {
  // final String apiKey = '27f1955b614aba1bb6610eb4fd435202';
  // final String baseUrl = 'https://api.themoviedb.org/3/movie';

  final String? apiKey=dotenv.env['API_KEY'];
  final String? baseUrl=dotenv.env['API_BASE_URL'];

  Future<Movie> fetchMovie(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/$movieId?api_key=$apiKey'));

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        //print(jsonResponse.toString());
        jsonResponse.forEach((key, value) {
          print('Key: $key, Data Type: ${value.runtimeType}');
        });

        return Movie.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to parse movie data: $e');
      }
    } else {
      throw Exception('Failed to load movie. Status code: ${response.statusCode}');
    }
  }


  Future<List<Movie>> fetchAllMovie() async {
    final response = await http.get(Uri.parse('$baseUrl/popular?api_key=$apiKey'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());
        jsonResponse.forEach((key, value) {
          print('Key: $key, Data Type: ${value.runtimeType}');
        });

        List<dynamic> data = jsonResponse['results'].sublist(0, 20);
        return data.map((movie) => Movie.fromJson(movie)).toList();

      } catch (e) {
        throw Exception('Failed to parse movie data: $e');
      }
    } else {
      throw Exception('Failed to load movie. Status code: ${response.statusCode}');
    }
  }


}
