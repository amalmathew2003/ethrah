import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductController with ChangeNotifier {
  final supabase = Supabase.instance.client;

  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  /// Getters
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// 📥 Fetch products
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supabase
          .from('products')
          .select()
          .order('created_at', ascending: false);

      _products =
          (response as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 📤 Add product
  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    required File imageFile,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      /// Upload image
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      await supabase.storage.from('products').upload(fileName, imageFile);

      final imageUrl = supabase.storage.from('products').getPublicUrl(fileName);

      /// Insert product
      await supabase.from('products').insert({
        'name': name,
        'description': description,
        'price': price,
        'image_url': imageUrl,
      });

      await fetchProducts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// ✏️ Update product
  Future<void> updateProduct(ProductModel product) async {
    try {
      _isLoading = true;
      notifyListeners();

      await supabase
          .from('products')
          .update(product.toJson())
          .eq('id', product.id);

      await fetchProducts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// 🗑️ Delete product
  Future<void> deleteProduct(String id) async {
    try {
      await supabase.from('products').delete().eq('id', id);

      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
