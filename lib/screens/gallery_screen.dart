import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../data/dummy_data.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/cards/gallery_card.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _selectedFilter = 'all';
  late List _filteredGallery;

  @override
  void initState() {
    super.initState();
    _updateFilter();
  }

  void _updateFilter() {
    if (_selectedFilter == 'all') {
      _filteredGallery = DummyData.galleryItems;
    } else {
      _filteredGallery = DummyData.galleryItems
          .where((item) => item.category == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNavBar(currentRoute: '/gallery'),

            // Header
            _buildHeader(isMobile),

            // Filter Section
            _buildFilterSection(isMobile),

            // Gallery Grid
            _buildGalleryGrid(isMobile),

            const AppFooter(),
          ],
        ),
      ),
    );
  }

  /// Header Section
  Widget _buildHeader(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      color: AppColors.ivory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Gallery',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBrown,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Explore our curated moments of elegance and tradition',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
            ),
          ),
        ],
      ),
    );
  }

  /// Filter Section with Category Tabs
  Widget _buildFilterSection(bool isMobile) {
    final categories = [
      'all',
      'Ethnic',
      'Contemporary',
      'Jewelry',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 20 : 32,
      ),
      color: AppColors.cream,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories
              .map((category) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildFilterTab(
                      label: category == 'all' ? 'All' : category,
                      value: category == 'all' ? 'all' : category,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  /// Individual Filter Tab
  Widget _buildFilterTab({
    required String label,
    required String value,
  }) {
    final isActive = _selectedFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = value;
          _updateFilter();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.gold : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.gold : AppColors.border,
            width: isActive ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.darkBrown,
          ),
        ),
      ),
    );
  }

  /// Gallery Grid
  Widget _buildGalleryGrid(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: isMobile ? 24 : 40,
      ),
      color: AppColors.cream,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = isMobile ? 2 : 4;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile ? 8 : 16,
              mainAxisSpacing: isMobile ? 8 : 16,
              childAspectRatio: 1,
            ),
            itemCount: _filteredGallery.length,
            itemBuilder: (context, index) {
              return GalleryCard(
                item: _filteredGallery[index],
                onTap: () => _showGalleryModal(index),
              );
            },
          );
        },
      ),
    );
  }

  /// Modal to view full image
  void _showGalleryModal(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Black backdrop
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
            // Image Container
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                child: Image.network(
                  _filteredGallery[index].imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Close Button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.darkBrown,
                    size: 24,
                  ),
                ),
              ),
            ),
            // Title at Bottom
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _filteredGallery[index].title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (_filteredGallery[index].category != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _filteredGallery[index].category!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.gold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
