import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken) async {
    final url = Uri.parse(
        'https://shop-app-3be3b-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    var oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.patch(
          url, body: json.encode({
        'isFavorite': isFavorite,
      }));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException('Couldn\'t resolve');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
      throw error;
    }
  }
}