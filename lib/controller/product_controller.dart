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
          tagline: 'Where Elegance Meets Tradition',
          story: 'Ethrah means abundance, beauty and inner radiance. It represents a person who carries elegance, confidence and a natural glow that shines from within. Our brand is inspired by the timeless beauty of Kerala.',
          mission: 'To create exquisite ethnic and contemporary wear that empowers women to express their identity with pride and elegance.',
          vision: 'To become the go-to destination for women seeking premium, ethically-crafted ethnic wear and jewelry that transcends generations.',
          founderNote: 'This brand was born from a love for timeless style and meaningful design. Every piece we sell—whether clothing or jewelry—is chosen to help you express yourself with confidence and ease. We believe in quality, simplicity, and details that make a difference.',
          founderName: 'Sandra & Sona',
          instagramHandle: 'ethrah.in',
          whatsappNumber: '+91 98765 43210',
          email: 'hello@ethrah.in',
        );
      }
    } catch (e) {
      print('Error fetching brand info: $e');
      // Use defaults on error too
      if (_brandInfo == null) {
        _brandInfo = BrandInfo(
          name: 'Ethrah',
          tagline: 'Where Elegance Meets Tradition',
          story: 'Ethrah means abundance, beauty and inner radiance.',
          mission: 'To create exquisite ethnic and contemporary wear.',
          vision: 'To be a global symbol of craftsmanship.',
          founderNote: 'This brand was born from a love for timeless style and meaningful design.',
          founderName: 'Sandra & Sona',
          instagramHandle: 'ethrah.in',
          whatsappNumber: '+91 98765 43210',
          email: 'hello@ethrah.in',
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
