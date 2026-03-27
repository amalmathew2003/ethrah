class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String material;
  final String careInstructions;
  final List<String> galleryImages;
  final bool isActive;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.material,
    required this.careInstructions,
    required this.galleryImages,
    required this.isActive,
    required this.createdAt,
  });

  /// 🔁 From JSON (Supabase → Flutter)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? 'ethnic',
      material: json['material'] ?? '',
      careInstructions: json['care_instructions'] ?? '',
      galleryImages: List<String>.from(
          json['gallery_images'] ?? [json['image_url'] ?? '']),
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// 🔁 To JSON (Flutter → Supabase)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category': category,
      'material': material,
      'care_instructions': careInstructions,
      'gallery_images': galleryImages,
      'is_active': isActive,
    };
  }
}
