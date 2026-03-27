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

  /// 📥 Fetch all products from Supabase
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await supabase
          .from('products')
          .select()
          .order('created_at', ascending: false);

      _products =
          (response as List).map((e) => ProductModel.fromJson(e)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch products: ${e.toString()}';
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Get product by ID
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get products by category
  List<ProductModel> getProductsByCategory(String category) {
    return _products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
