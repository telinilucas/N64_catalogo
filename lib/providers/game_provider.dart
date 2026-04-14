import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/api_service.dart';

class GameProvider with ChangeNotifier {
  List<Game> _games = [];
  bool _isLoading = true; 

  List<Game> get games => _games;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  GameProvider() {
    loadGames(); 
  }

  Future<void> loadGames() async {
    _isLoading = true;
    notifyListeners(); 

    try {
      _games = await _apiService.getN64Games();
    } catch (e) {
      debugPrint('Erro ao buscar jogos: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}