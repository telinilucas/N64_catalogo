import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<int> _favoriteIds = [];
  List<int> get favoriteIds => _favoriteIds;

  FavoriteProvider() {
    _listenToFavorites();
  }

  // Fica "escutando" o banco de dados em tempo real
  void _listenToFavorites() {
    final user = _auth.currentUser;
    if (user == null) return;

    _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots()
        .listen((snapshot) {
      _favoriteIds = snapshot.docs.map((doc) => int.parse(doc.id)).toList();
      notifyListeners();
    });
  }

  Future<void> toggleFavorite(int gameId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(gameId.toString());

    if (_favoriteIds.contains(gameId)) {
      await docRef.delete(); // Se já é favorito, remove
    } else {
      await docRef.set({'addedAt': FieldValue.serverTimestamp()}); // Se não é, adiciona
    }
  }

  bool isFavorite(int gameId) {
    return _favoriteIds.contains(gameId);
  }
}