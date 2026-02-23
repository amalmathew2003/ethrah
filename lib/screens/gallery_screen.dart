import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            const AppNavBar(currentRoute: '/gallery')
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0),

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
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Explore our curated moments of elegance and tradition',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 800.ms)
              .slideY(begin: 0.1, end: 0),
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
          children: categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildFilterTab(
                label: category == 'all' ? 'All' : category,
                value: category == 'all' ? 'all' : category,
              ),
            )
                .animate()
                .fadeIn(delay: (index * 50).ms)
                .slideX(begin: 0.1, end: 0);
          }).toList(),
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.gold : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.gold : AppColors.border,
            width: isActive ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
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

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: GridView.builder(
              key: ValueKey<String>(_selectedFilter),
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
                )
                    .animate()
                    .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                    .scale(begin: const Offset(0.9, 0.9));
              },
            ),
          );
        },
      ),
    );
  }

  /// Modal to view full image
  void _showGalleryModal(int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Gallery Preview',
      barrierColor: Colors.black.withValues(alpha: 0.8),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image Container
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        _filteredGallery[index].imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ).animate().scale(begin: const Offset(0.9, 0.9)).fadeIn(),
                // Close Button
                Positioned(
                  top: 40,
                  right: 40,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 32),
                    onPressed: () => Navigator.pop(context),
                  ).animate().fadeIn(delay: 200.ms),
                ),
                // Title at Bottom
                Positioned(
                  bottom: 40,
                  left: 40,
                  right: 40,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _filteredGallery[index].title,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          if (_filteredGallery[index].category != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              _filteredGallery[index].category!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.gold,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, a1, a2, child) {
        return FadeTransition(
          opacity: a1,
          child: child,
        );
      },
    );
  }
}
