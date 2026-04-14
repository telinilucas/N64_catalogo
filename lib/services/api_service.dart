import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';

class ApiService {
  static const String apiKey = '8dfb221173364f5eb8ad0bd65f44597d'; 
  static const String baseUrl = 'https://api.rawg.io/api';

  Future<List<Game>> getN64Games() async {
    final url = Uri.parse('$baseUrl/games?key=$apiKey&platforms=83&ordering=-rating&page_size=20');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        
        return results.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar jogos da API');
      }
    } catch (e) {
      throw Exception('Falha na conexão: $e');
    }
  }
}