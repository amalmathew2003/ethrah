import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_colors.dart';
import '../config/app_routes.dart';
import '../data/dummy_data.dart';
import '../models/models.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/common/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product product;
  int _selectedImageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Find product by ID
    product = _getProductById(widget.productId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Product _getProductById(String id) {
    for (var collection in DummyData.allCollections) {
      for (var product in collection.products) {
        if (product.id == id) {
          return product;
        }
      }
    }
    // Default product if not found
    return DummyData.ethnicSaree;
  }

  void _openWhatsApp() {
    // WhatsApp link would be opened here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Redirecting to WhatsApp...'),
        backgroundColor: AppColors.gold,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _sendEmail() {
    // Email link would be opened here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening email...'),
        backgroundColor: AppColors.gold,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const AppNavBar(currentRoute: AppRoutes.productDetail)
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0),

            // Product Detail Section
            _buildProductDetail(isMobile),

            // Related Products Section
            _buildRelatedProducts(isMobile),

            const AppFooter(),
          ],
        ),
      ),
    );
  }

  /// Product Detail Section with Image and Information
  Widget _buildProductDetail(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 30 : 50,
      ),
      color: AppColors.cream,
      child: isMobile
          ? Column(
              children: [
                _buildImageGallery(isMobile),
                SizedBox(height: isMobile ? 32 : 48),
                _buildProductInfo(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildImageGallery(isMobile)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideX(begin: -0.05, end: 0),
                ),
                SizedBox(width: isMobile ? 24 : 60),
                Expanded(
                  flex: 1,
                  child: _buildProductInfo(isMobile)
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 800.ms)
                      .slideX(begin: 0.05, end: 0),
                ),
              ],
            ),
    );
  }

  /// Image Gallery Section
  Widget _buildImageGallery(bool isMobile) {
    return Column(
      children: [
        // Main Image
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Image.network(
                product.galleryImages[_selectedImageIndex],
                key: ValueKey<int>(_selectedImageIndex),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.beige,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.mediumBrown,
                        size: 64,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),

        // Thumbnail Gallery
        SizedBox(
          height: isMobile ? 80 : 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.galleryImages.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedImageIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedImageIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isMobile ? 80 : 100,
                  height: isMobile ? 80 : 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected ? AppColors.gold : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.gold.withValues(alpha: 0.3),
                              blurRadius: 8,
                            ),
                          ]
                        : [],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      product.galleryImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Product Information Section
  Widget _buildProductInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Name
        Text(
          product.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 32 : 40,
            fontWeight: FontWeight.w700,
            color: AppColors.darkBrown,
          ),
        ).animate().fadeIn().slideY(begin: 0.1, end: 0),
        SizedBox(height: isMobile ? 12 : 16),

        // Category Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.lightGold.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            product.category.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
              letterSpacing: 1,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: isMobile ? 16 : 24),

        // Price
        Text(
          product.price,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 28 : 32,
            fontWeight: FontWeight.w700,
            color: AppColors.gold,
          ),
        ).animate().fadeIn(delay: 300.ms),
        SizedBox(height: isMobile ? 20 : 28),

        // Description
        Text(
          'Description',
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14 : 15,
            color: AppColors.darkBrown,
            height: 1.8,
          ),
        ).animate().fadeIn(delay: 500.ms),
        SizedBox(height: isMobile ? 24 : 32),

        // Material/Fabric Details
        _buildDetailSection(
          title: 'Material & Details',
          content: product.material,
          isMobile: isMobile,
          delay: 600,
        ),
        SizedBox(height: isMobile ? 20 : 28),

        // Care Instructions
        _buildDetailSection(
          title: 'Care Instructions',
          content: product.careInstructions,
          isMobile: isMobile,
          delay: 700,
        ),
        SizedBox(height: isMobile ? 28 : 40),

        // Action Buttons
        _buildActionButtons(isMobile),
      ],
    );
  }

  /// Detail Section (Material/Care)
  Widget _buildDetailSection({
    required String title,
    required String content,
    required bool isMobile,
    int delay = 0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 13 : 14,
            color: AppColors.mediumBrown,
            height: 1.7,
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.1, end: 0);
  }

  /// Action Buttons (Enquiry)
  Widget _buildActionButtons(bool isMobile) {
    return Column(
      children: [
        // Enquiry Buttons
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: 'Enquire on WhatsApp',
                icon: Icons.call,
                onPressed: _openWhatsApp,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: 'Send Email',
                icon: Icons.email_outlined,
                onPressed: _sendEmail,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 20 : 28),

        // Continue Shopping Button
        Row(
          children: [
            Expanded(
              child: TextActionButton(
                text: 'Back to Collections',
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.collections,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 800.ms).scale(begin: const Offset(0.95, 0.95));
  }

  /// Related Products Section
  Widget _buildRelatedProducts(bool isMobile) {
    // Get related products from same category
    final relatedProducts = DummyData.allCollections
        .firstWhere(
          (collection) => collection.id == product.category,
          orElse: () => DummyData.allCollections[0],
        )
        .products
        .where((p) => p.id != product.id)
        .take(3)
        .toList();

    if (relatedProducts.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      color: AppColors.ivory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Products',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ).animate().fadeIn().slideX(begin: -0.1, end: 0),
          SizedBox(height: isMobile ? 24 : 32),

          // Related Products Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 3;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 16 : 24,
                  mainAxisSpacing: isMobile ? 16 : 24,
                  childAspectRatio: 0.65,
                ),
                itemCount: relatedProducts.length,
                itemBuilder: (context, index) {
                  return _buildRelatedProductCard(relatedProducts[index])
                      .animate()
                      .fadeIn(delay: (index * 150).ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Related Product Card
  Widget _buildRelatedProductCard(Product relatedProduct) {
    return _RelatedProductCard(
      relatedProduct: relatedProduct,
      onTap: () {
        // Navigate to related product
        setState(() {
          product = relatedProduct;
          _selectedImageIndex = 0;
        });
        // Scroll to top
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}

class _RelatedProductCard extends StatefulWidget {
  final Product relatedProduct;
  final VoidCallback onTap;

  const _RelatedProductCard({
    required this.relatedProduct,
    required this.onTap,
  });

  @override
  State<_RelatedProductCard> createState() => _RelatedProductCardState();
}

class _RelatedProductCardState extends State<_RelatedProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow
                    .withValues(alpha: _isHovered ? 0.12 : 0.08),
                blurRadius: _isHovered ? 20 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: AppColors.beige,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: Image.network(
                        widget.relatedProduct.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.relatedProduct.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.relatedProduct.price,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
