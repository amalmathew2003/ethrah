import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../models/models.dart';

/// Product card for displaying items in grid layout
/// Shows image, title, and description with hover effects
class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  void _navigateToDetail() {
    Navigator.pushNamed(
      context,
      AppRoutes.productDetail,
      arguments: {'id': widget.product.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _navigateToDetail,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: _isHovered
              ? Matrix4.translationValues(0, -8, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow
                    .withValues(alpha: _isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 24 : 12,
                offset: Offset(0, _isHovered ? 12 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    color: AppColors.lightBeige,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Product Image with Scale
                      AnimatedScale(
                        scale: _isHovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        child: Image.network(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.beige,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.mediumBrown,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Hover Overlay
                      AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          color: AppColors.darkOverlay.withValues(alpha: 0.3),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'View Details',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkBrown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            widget.product.name,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkBrown,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Description
                          Text(
                            widget.product.description,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.mediumBrown,
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      // Price
                      Text(
                        widget.product.price,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
