import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Responsive footer with brand info, links, and social media
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.darkBrown,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Footer Content
          if (isMobile) _buildMobileFooter() else _buildDesktopFooter(),

          // Divider
          SizedBox(height: isMobile ? 30 : 40),
          Divider(color: AppColors.lightBeige.withValues(alpha: 0.2)),

          // Copyright
          SizedBox(height: isMobile ? 20 : 30),
          Center(
            child: Text(
              '© 2024 Ethrah. All rights reserved. | Crafted with ❤️ for you',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 12 : 13,
                color: AppColors.lightBeige.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Desktop footer layout
  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ethrah',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Where Elegance Meets Tradition',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.lightBeige,
                ),
              ),
              const SizedBox(height: 20),
              _buildSocialLinks(),
            ],
          ),
        ),
        // Quick Links
        Expanded(
          child: _buildFooterSection(
            'Quick Links',
            ['Home', 'Collections', 'About', 'Gallery', 'Contact'],
          ),
        ),
        // Information
        Expanded(
          child: _buildFooterSection(
            'Information',
            ['About Us', 'Sustainability', 'Care Guide', 'FAQ', 'Shipping'],
          ),
        ),
        // Contact
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                'Email',
                'hello@ethrah.in',
              ),
              _buildContactItem(
                'WhatsApp',
                '+91 98765 43210',
              ),
              _buildContactItem(
                'Instagram',
                '@ethrah.in',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Mobile footer layout
  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Section
        Text(
          'Ethrah',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Where Elegance Meets Tradition',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.lightBeige,
          ),
        ),
        const SizedBox(height: 24),
        // Social Links
        _buildSocialLinks(),
        const SizedBox(height: 30),
        // Quick Links
        _buildFooterSection(
          'Quick Links',
          ['Home', 'Collections', 'About', 'Gallery', 'Contact'],
        ),
        const SizedBox(height: 24),
        // Contact
        _buildFooterSection(
          'Contact',
          ['hello@ethrah.in', '+91 98765 43210', '@ethrah.in'],
        ),
      ],
    );
  }

  /// Footer section with title and items
  Widget _buildFooterSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.lightBeige.withValues(alpha: 0.8),
                ),
              ),
            )),
      ],
    );
  }

  /// Contact item with label and value
  Widget _buildContactItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.lightBeige.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  /// Social media links
  Widget _buildSocialLinks() {
    return Row(
      children: [
        _buildSocialIcon(Icons.language, 'Website'),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.camera_alt_outlined, 'Instagram'),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.call, 'WhatsApp'),
      ],
    );
  }

  /// Individual social icon
  Widget _buildSocialIcon(IconData icon, String label) {
    return Tooltip(
      message: label,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.gold.withValues(alpha: 0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.gold,
        ),
      ),
    );
  }
}
