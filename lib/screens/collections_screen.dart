import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../config/app_routes.dart';
import '../data/dummy_data.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/cards/product_card.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  String _selectedFilter = 'all'; // 'all', 'ethnic', 'contemporary', 'jewellery'

  List _getFilteredCollections() {
    if (_selectedFilter == 'all') {
      return DummyData.allCollections;
    }
    return DummyData.allCollections
        .where((collection) => collection.id == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNavBar(currentRoute: AppRoutes.collections),
            
            // Header
            _buildHeader(isMobile),
            
            // Filter Section
            _buildFilterSection(isMobile),
            
            // Collections Grid
            _buildCollectionsGrid(isMobile),
            
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
            'Our Collections',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBrown,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Curated collections of ethnic wear and jewelry for every occasion',
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
    final filters = [
      {'label': 'All Collections', 'value': 'all'},
      {'label': 'Ethnic Wear', 'value': 'ethnic'},
      {'label': 'Contemporary', 'value': 'contemporary'},
      {'label': 'Jewellery', 'value': 'jewellery'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 24 : 40,
      ),
      color: AppColors.cream,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters
              .map((filter) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildFilterButton(
                      label: filter['label'] as String,
                      value: filter['value'] as String,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  /// Individual Filter Button
  Widget _buildFilterButton({
    required String label,
    required String value,
  }) {
    final isActive = _selectedFilter == value;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.gold : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.gold : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.darkBrown,
          ),
        ),
      ),
    );
  }

  /// Collections Grid
  Widget _buildCollectionsGrid(bool isMobile) {
    final collections = _getFilteredCollections();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      color: AppColors.cream,
      child: Column(
        children: collections
            .map((collection) => _buildCollectionSection(
              collection,
              isMobile,
            ))
            .toList(),
      ),
    );
  }

  /// Individual Collection Section with Products
  Widget _buildCollectionSection(dynamic collection, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Collection Header
        Text(
          collection.name,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          collection.description,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 13 : 15,
            color: AppColors.mediumBrown,
            height: 1.6,
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        
        // Products Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = isMobile ? 1 : 3;
            final childAspectRatio = isMobile ? 0.65 : 0.65;
            
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: isMobile ? 16 : 24,
                mainAxisSpacing: isMobile ? 16 : 24,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: collection.products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: collection.products[index],
                );
              },
            );
          },
        ),
        
        SizedBox(height: isMobile ? 48 : 64),
      ],
    );
  }
}
