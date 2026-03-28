import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';
import '../models/models.dart';

class ProductController with ChangeNotifier {
  final supabase = Supabase.instance.client;

  List<ProductModel> _products = [];
  List<GalleryItem> _galleryItems = [];
  BrandInfo? _brandInfo;
  bool _isLoading = false;
  String? _error;

  /// Getters
  List<ProductModel> get products => _products;
  List<GalleryItem> get galleryItems => _galleryItems;
  BrandInfo? get brandInfo => _brandInfo;
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
 
      _products = response
          .map((e) => ProductModel.fromJson(e))
          .toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to fetch products: ${e.toString()}';
      print('Error fetching products: $e');
      _products = [];
    }
 
    _isLoading = false;
    notifyListeners();
  }

  /// 📥 Fetch all gallery items from Supabase
  Future<void> fetchGallery() async {
    try {
      final response = await supabase
          .from('gallery')
          .select()
          .order('id', ascending: true);
 
      _galleryItems = response
          .map((e) => GalleryItem.fromJson(e))
          .toList();
    } catch (e) {
      print('Error fetching gallery: $e');
    }

    if (_galleryItems.isEmpty) {
      // If products are already available, use them. If not, don't re-trigger a fetch here to avoid recursion if fetchAllData is used.
      // But we can peek at _products.
      if (_products.isNotEmpty) {
        _galleryItems = _products.take(8).map((p) => GalleryItem(
          id: p.id,
          imageUrl: p.imageUrl,
          title: p.name,
        )).toList();
      }
    }
    notifyListeners();
  }

  /// 📥 Fetch brand info from Supabase
  Future<void> fetchBrandInfo() async {
    try {
      final response = await supabase
          .from('brand_info')
          .select()
          .maybeSingle();
 
      if (response != null) {
        _brandInfo = BrandInfo.fromJson(response);
      } else {
        // Fallback to default brand info if table is missing or empty
        _brandInfo = BrandInfo(
          name: 'Ethrah',
          tagline: 'Timeless Elegance, Modern Tradition',
          story: 'Founded in the heart of Kerala, Ethrah is dedicated to preserving the rich heritage of jewelry making while embracing contemporary designs. Every piece we create tells a story of craftsmanship, passion, and elegance.',
          mission: 'Our mission is to create exquisite jewelry that makes every woman feel extraordinary, blending artistic tradition with modern sophistication.',
          vision: 'To be the preferred choice for discerning individuals seeking unique, high-quality jewelry that celebrates cultural heritage and contemporary style.',
          founderNote: 'Ethrah was born out of a desire to create jewelry that isn\'t just an accessory, but an extension of one\'s personality.',
          founderName: 'Ethrah Creative Team',
          instagramHandle: 'ethrah_official',
          whatsappNumber: '+91 999 000 0000',
          email: 'contact@ethrah.com',
        );
      }
    } catch (e) {
      print('Error fetching brand info: $e');
      // Use defaults on error too
      if (_brandInfo == null) {
        _brandInfo = BrandInfo(
          name: 'Ethrah',
          tagline: 'Timeless Elegance, Modern Tradition',
          story: 'Preserving heritage with elegance.',
          mission: 'To create exquisite jewelry for the modern woman.',
          vision: 'To be a global symbol of craftsmanship.',
          founderNote: 'Our journey is built on passion for art and tradition.',
          founderName: 'Team Ethrah',
          instagramHandle: 'ethrah_official',
          whatsappNumber: '+91 999 000 0000',
          email: 'contact@ethrah.com',
        );
      }
    }
    notifyListeners();
  }

  /// 📥 Fetch all data at once
  Future<void> fetchAllData() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.wait([
      fetchProducts(),
      fetchGallery(),
      fetchBrandInfo(),
    ]);
    
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

}
