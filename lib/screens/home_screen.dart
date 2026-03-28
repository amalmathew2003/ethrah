import 'package:ethrah_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../config/app_routes.dart';

import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/cards/product_card.dart';
import '../widgets/cards/gallery_card.dart';
import '../data/dummy_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when home screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Navigation Bar
                const AppNavBar(currentRoute: AppRoutes.home)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2, end: 0),

                // Hero Banner Section
                _buildHeroBanner(isMobile),

                // Featured Collections Section
                _buildFeaturedCollections(isMobile, productController),

                // About Preview Section
                _buildAboutPreview(isMobile, productController),

                // Gallery Preview Section
                _buildGalleryPreview(isMobile, productController),

                // CTA Section
                _buildCTASection(isMobile),

                // Footer
                const AppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Hero Banner with brand name and tagline
  Widget _buildHeroBanner(bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? 500 : 700,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.ivory,
            AppColors.cream,
            AppColors.lightBeige,
          ],
        ),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=1200&q=80',
          ),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ethrah',
              style: GoogleFonts.playfairDisplay(
                fontSize: isMobile ? 56 : 96,
                fontWeight: FontWeight.w700,
                color: AppColors.darkBrown,
                letterSpacing: -2,
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                .slideY(begin: 0.3, end: 0)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
            SizedBox(height: isMobile ? 12 : 20),
            Text(
              'Where Elegance Meets Tradition',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 16 : 24,
                fontWeight: FontWeight.w300,
                color: AppColors.mediumBrown,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideY(begin: 0.1, end: 0),
            SizedBox(height: isMobile ? 32 : 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  text: 'Explore Collections',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.collections,
                  ),
                ),
                SizedBox(width: isMobile ? 12 : 16),
                SecondaryButton(
                  text: 'Learn More',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.about,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .scaleY(begin: 0.8, end: 1),
          ],
        ),
      ),
    );
  }

  /// Featured Collections Section
  Widget _buildFeaturedCollections(bool isMobile, ProductController productController) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.cream,
      child: Column(
        children: [
          // Section Header
          Text(
            'Featured Collections',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ).animate().shimmer(
              delay: 2.seconds,
              duration: 2.seconds,
              color: AppColors.gold.withValues(alpha: 0.2)),

          SizedBox(height: isMobile ? 12 : 20),
          Text(
            'Discover our curated selection of ethnic and contemporary wear',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 200.ms),
          SizedBox(height: isMobile ? 40 : 60),

          // Products Grid
          // Removed duplicate Consumer here as it is now at the top level
          Builder(
            builder: (context) {
              if (productController.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                  ),
                );
              }

              if (productController.error != null) {
                return Center(
                  child: Text(
                    'Error: ${productController.error}',
                    style: GoogleFonts.poppins(color: AppColors.mediumBrown),
                  ),
                );
              }

              final products = productController.products.take(3).toList();

              if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No products available',
                    style: GoogleFonts.poppins(color: AppColors.mediumBrown),
                  ),
                );
              }

              return LayoutBuilder(
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
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: products[index],
                      )
                          .animate()
                          .fadeIn(delay: (index * 200).ms, duration: 600.ms)
                          .slideY(begin: 0.2, end: 0);
                    },
                  );
                },
              );
            },
          ),

          SizedBox(height: isMobile ? 32 : 48),
          PrimaryButton(
            text: 'View All Collections',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.collections,
            ),
          )
              .animate()
              .fadeIn(delay: 800.ms)
              .scale(begin: const Offset(0.9, 0.9)),
        ],
      ),
    );
  }

  /// About Preview Section
  Widget _buildAboutPreview(bool isMobile, ProductController productController) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.ivory,
      child: Row(
        children: [
          // Image
          if (!isMobile)
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/home_about.png',
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0),
            ),
          if (!isMobile) const SizedBox(width: 60),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Ethrah',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isMobile ? 32 : 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
                  ),
                ).animate().fadeIn().slideX(begin: 0.1, end: 0),
                SizedBox(height: isMobile ? 16 : 24),
                Text(
                  (productController.brandInfo?.story != null &&
                          productController.brandInfo!.story.isNotEmpty)
                      ? productController.brandInfo!.story
                      : DummyData.brandInfo.story,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: AppColors.darkBrown,
                    height: 1.8,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                SizedBox(height: isMobile ? 24 : 32),
                SecondaryButton(
                  text: 'Read Full Story',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.about,
                  ),
                ).animate().fadeIn(delay: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Gallery Preview Section (Instagram Grid Style)
  Widget _buildGalleryPreview(bool isMobile, ProductController productController) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.cream,
      child: Column(
        children: [
          Text(
            'Gallery Moments',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
          SizedBox(height: isMobile ? 12 : 20),
          Text(
            'Moments of elegance and tradition',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
            ),
          ).animate().fadeIn(delay: 200.ms),
          SizedBox(height: isMobile ? 40 : 60),

          // Gallery Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 2 : 4;

              final displayCount = productController.galleryItems.length > 8 ? 8 : productController.galleryItems.length;

              if (displayCount == 0) {
                return const SizedBox.shrink(); // Hide if empty
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 12 : 16,
                  mainAxisSpacing: isMobile ? 12 : 16,
                  childAspectRatio: 1,
                ),
                itemCount: displayCount,
                itemBuilder: (context, index) {
                  return GalleryCard(
                    item: productController.galleryItems[index],
                  )
                      .animate()
                      .fadeIn(delay: (index * 100).ms, duration: 400.ms)
                      .scale(begin: const Offset(0.8, 0.8));
                },
              );
            },
          ),

          SizedBox(height: isMobile ? 32 : 48),
          PrimaryButton(
            text: 'View Gallery',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.gallery,
            ),
          ).animate().fadeIn(delay: 1.seconds),
        ],
      ),
    );
  }

  /// CTA Section with Contact Button
  Widget _buildCTASection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      color: AppColors.darkBrown,
      child: Column(
        children: [
          Text(
            'Get In Touch',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.w600,
              color: AppColors.gold,
            ),
          ).animate().shimmer(duration: 3.seconds, color: Colors.white24),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Have questions? We\'d love to hear from you.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.ivory,
            ),
          ).animate().fadeIn(delay: 200.ms),
          SizedBox(height: isMobile ? 24 : 32),
          PrimaryButton(
            text: 'Contact Us',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.contact,
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms)
              .shake(delay: 2.seconds, hz: 4, curve: Curves.easeInOut),
        ],
      ),
    );
  }
}
