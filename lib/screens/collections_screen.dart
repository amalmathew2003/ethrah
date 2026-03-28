import 'package:ethrah_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../config/app_routes.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/cards/product_card.dart';
import '../models/product_model.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  String _selectedFilter =
      'all'; // 'all', 'ethnic', 'contemporary', 'jewellery'

  @override
  void initState() {
    super.initState();
    // Fetch products when collections screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().fetchProducts();
    });
  }

  List<ProductModel> _getFilteredProducts(List<ProductModel> allProducts) {
    if (_selectedFilter == 'all') return allProducts;
    return allProducts.where((p) => p.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNavBar(currentRoute: AppRoutes.collections)
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0),

            // Header
            _buildHeader(isMobile),

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
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Curated collections of ethnic wear and jewelry for every occasion',
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





  /// Collections Grid
  Widget _buildCollectionsGrid(bool isMobile) {
    return Consumer<ProductController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
              ),
            ),
          );
        }

        if (controller.error != null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
              child: Text(
                'Error: ${controller.error}',
                style: GoogleFonts.poppins(color: AppColors.mediumBrown),
              ),
            ),
          );
        }

        final filteredProducts = _getFilteredProducts(controller.products);

        if (filteredProducts.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
              child: Text(
                'No products in this category',
                style: GoogleFonts.poppins(color: AppColors.mediumBrown),
              ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: isMobile ? 40 : 60,
          ),
          color: AppColors.cream,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Column(
              key: ValueKey<String>(_selectedFilter),
              children: [
                _buildFilterSection(isMobile, controller.products),
                SizedBox(height: isMobile ? 24 : 32),
                _buildCategoryHeader(isMobile),
                SizedBox(height: isMobile ? 24 : 32),
                _buildProductsGrid(filteredProducts, isMobile),
              ],
            ),
          ),
        );
      },
    );
  }
  /// Filter Section with Category Tabs
  Widget _buildFilterSection(bool isMobile, List<ProductModel> allProducts) {
    final categories = ['all', ...allProducts.map((p) => p.category).toSet().toList()];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isActive = _selectedFilter.toLowerCase() == category.toLowerCase();
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selectedFilter = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
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
                    category.capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : AppColors.darkBrown,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  /// Category Header
  Widget _buildCategoryHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Fine Collection',
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ).animate().fadeIn().slideX(begin: -0.1, end: 0),
        const SizedBox(height: 8),
        Text(
          'Explore our finest collection',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 13 : 15,
            color: AppColors.mediumBrown,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }

  /// Products Grid
  Widget _buildProductsGrid(List products, bool isMobile) {
    return LayoutBuilder(
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
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
            )
                .animate()
                .fadeIn(delay: (index * 150).ms, duration: 600.ms)
                .slideY(begin: 0.2, end: 0);
          },
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
