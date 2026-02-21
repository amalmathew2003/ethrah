import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/app_colors.dart';
import '../../models/models.dart';

/// Gallery card for Instagram-style grid layout
/// Shows image with title overlay on hover
class GalleryCard extends StatefulWidget {
  final GalleryItem item;
  final VoidCallback? onTap;

  const GalleryCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  State<GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
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
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow
                    .withValues(alpha: _isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image with Scale
                AnimatedScale(
                  scale: _isHovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: Image.network(
                    widget.item.imageUrl,
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
                // Overlay
                AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.darkBrown.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.item.title,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                            .animate(target: _isHovered ? 1 : 0)
                            .fadeIn(duration: 300.ms)
                            .slideY(begin: 0.2, end: 0),
                        if (widget.item.category != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.item.category!,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: AppColors.gold,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                              .animate(target: _isHovered ? 1 : 0)
                              .fadeIn(delay: 100.ms, duration: 300.ms)
                              .slideY(begin: 0.2, end: 0),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
