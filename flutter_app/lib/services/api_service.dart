import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/game.dart';

class ApiService {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000',
  );

  static Uri _uri(String path) => Uri.parse('$baseUrl$path');

  static Map<String, String> get _headers => {
        'Content-Type': 'application/json; charset=utf-8',
      };

  Future<List<GameCategory>> fetchCategories() async {
    final response = await http.post(
      _uri('/categories'),
      headers: _headers,
    );

    final decoded = _decode(response);
    final List data = decoded['data'] as List;
    return data.map((item) => GameCategory.fromJson(item)).toList();
  }

  Future<List<Game>> fetchGamesByCategory(String category) async {
    final response = await http.post(
      _uri('/games/by-category'),
      headers: _headers,
      body: jsonEncode({'category': category}),
    );

    final decoded = _decode(response);
    final List data = decoded['data'] as List;
    return data.map((item) => Game.fromJson(item)).toList();
  }

  Future<Game> fetchGameDetail(int id) async {
    final response = await http.post(
      _uri('/games/detail'),
      headers: _headers,
      body: jsonEncode({'id': id}),
    );

    final decoded = _decode(response);
    return Game.fromJson(decoded['data'] as Map<String, dynamic>);
  }

  Future<List<Game>> searchGames(String query) async {
    final response = await http.post(
      _uri('/games/search'),
      headers: _headers,
      body: jsonEncode({'query': query}),
    );

    final decoded = _decode(response);
    final List data = decoded['data'] as List;
    return data.map((item) => Game.fromJson(item)).toList();
  }

  String imageUrl(String filename) => '$baseUrl/images/$filename';

  Map<String, dynamic> _decode(http.Response response) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(decoded['message'] ?? 'Error del servidor');
    }

    return decoded;
  }
}
