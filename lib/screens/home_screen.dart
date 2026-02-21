import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../config/app_routes.dart';
import '../data/dummy_data.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/cards/product_card.dart';
import '../widgets/cards/gallery_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar
            const AppNavBar(currentRoute: AppRoutes.home),

            // Hero Banner Section
            _buildHeroBanner(isMobile),

            // Featured Collections Section
            _buildFeaturedCollections(isMobile),

            // About Preview Section
            _buildAboutPreview(isMobile),

            // Gallery Preview Section
            _buildGalleryPreview(isMobile),

            // CTA Section
            _buildCTASection(isMobile),

            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  /// Hero Banner with brand name and tagline
  Widget _buildHeroBanner(bool isMobile) {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
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
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
            ),
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
                ),
                SizedBox(height: isMobile ? 12 : 20),
                Text(
                  'Where Elegance Meets Tradition',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 16 : 24,
                    fontWeight: FontWeight.w300,
                    color: AppColors.mediumBrown,
                    letterSpacing: 2,
                  ),
                ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Featured Collections Section
  Widget _buildFeaturedCollections(bool isMobile) {
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
          ),
          SizedBox(height: isMobile ? 12 : 20),
          Text(
            'Discover our curated selection of ethnic and contemporary wear',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
              height: 1.6,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),

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
                itemCount: 3,
                itemBuilder: (context, index) {
                  final products = [
                    DummyData.ethnicSaree,
                    DummyData.contemporarySalwar,
                    DummyData.jewellerySets,
                  ];
                  return ProductCard(product: products[index]);
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
          ),
        ],
      ),
    );
  }

  /// About Preview Section
  Widget _buildAboutPreview(bool isMobile) {
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
                child: Image.network(
                  'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
                  fit: BoxFit.cover,
                  height: 400,
                ),
              ),
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
                ),
                SizedBox(height: isMobile ? 16 : 24),
                Text(
                  DummyData.brandInfo.story,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: AppColors.darkBrown,
                    height: 1.8,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),
                SecondaryButton(
                  text: 'Read Full Story',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.about,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Gallery Preview Section (Instagram Grid Style)
  Widget _buildGalleryPreview(bool isMobile) {
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
          ),
          SizedBox(height: isMobile ? 12 : 20),
          Text(
            'Moments of elegance and tradition',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),

          // Gallery Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 2 : 4;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 12 : 16,
                  mainAxisSpacing: isMobile ? 12 : 16,
                  childAspectRatio: 1,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GalleryCard(
                    item: DummyData.galleryItems[index],
                  );
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
          ),
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
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Have questions? We\'d love to hear from you.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.ivory,
            ),
          ),
          SizedBox(height: isMobile ? 24 : 32),
          PrimaryButton(
            text: 'Contact Us',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.contact,
            ),
          ),
        ],
      ),
    );
  }
}
