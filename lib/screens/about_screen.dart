import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_colors.dart';
import '../data/dummy_data.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNavBar(currentRoute: '/about')
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: -0.2, end: 0),

            // Header Section
            _buildHeader(isMobile),

            // Brand Story Section
            _buildStorySection(isMobile),

            // Mission & Vision Section
            _buildMissionVisionSection(isMobile),

            // Founder Note Section
            _buildFounderSection(isMobile),

            // Values Section
            _buildValuesSection(isMobile),

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
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.ivory,
      child: Column(
        children: [
          Text(
            'About Ethrah',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBrown,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            'Celebrating tradition, embracing modernity',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w300,
              color: AppColors.mediumBrown,
              letterSpacing: 1,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 800.ms)
              .slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  /// Brand Story Section with Image and Text
  Widget _buildStorySection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.cream,
      child: Column(
        children: [
          // Text and Image Container
          if (isMobile)
            Column(
              children: [
                _buildStoryText(isMobile),
                const SizedBox(height: 32),
                _buildStoryImage(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildStoryImage()
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideX(begin: -0.1, end: 0),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 1,
                  child: _buildStoryText(isMobile)
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 800.ms)
                      .slideX(begin: 0.1, end: 0),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Story Text Content
  Widget _buildStoryText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Story',
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
      ],
    );
  }

  /// Story Image
  Widget _buildStoryImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
        fit: BoxFit.cover,
        height: 400,
      ),
    );
  }

  /// Mission & Vision Section
  Widget _buildMissionVisionSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.ivory,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mission Card
              Expanded(
                child: _buildMVCard(
                  title: 'Our Mission',
                  content: DummyData.brandInfo.mission,
                  icon: Icons.bolt,
                  isMobile: isMobile,
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
              ),
              if (!isMobile) const SizedBox(width: 32),
              // Vision Card
              Expanded(
                child: _buildMVCard(
                  title: 'Our Vision',
                  content: DummyData.brandInfo.vision,
                  icon: Icons.visibility,
                  isMobile: isMobile,
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.1, end: 0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Mission/Vision Card
  Widget _buildMVCard({
    required String title,
    required String content,
    required IconData icon,
    required bool isMobile,
  }) {
    return _InteractableCard(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.gold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Text(
              content,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 13 : 15,
                color: AppColors.darkBrown,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Founder Section
  Widget _buildFounderSection(bool isMobile) {
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
            'Founder\'s Note',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
          SizedBox(height: isMobile ? 32 : 48),

          // Founder Quote Card
          Container(
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            decoration: BoxDecoration(
              color: AppColors.ivory,
              borderRadius: BorderRadius.circular(4),
              border: const Border(
                left: BorderSide(
                  color: AppColors.gold,
                  width: 4,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quote Icon
                Text(
                  '"',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: AppColors.gold,
                    height: 0.8,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .shimmer(duration: 2.seconds),
                SizedBox(height: isMobile ? 8 : 16),
                // Quote Text
                Text(
                  DummyData.brandInfo.founderNote,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: AppColors.darkBrown,
                    height: 1.8,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 32),
                // Founder Name
                Text(
                  '— ${DummyData.brandInfo.founderName}',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
                  ),
                ),
                Text(
                  'Founder & Creative Director',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : 13,
                    color: AppColors.mediumBrown,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  /// Values Section
  Widget _buildValuesSection(bool isMobile) {
    final values = [
      {
        'title': 'Craftsmanship',
        'description':
            'We celebrate the art of skilled artisans and traditional techniques.',
        'icon': Icons.brush,
      },
      {
        'title': 'Quality',
        'description':
            'Premium materials and meticulous attention to detail in every piece.',
        'icon': Icons.check_circle,
      },
      {
        'title': 'Sustainability',
        'description':
            'Ethical practices and sustainable production for a better future.',
        'icon': Icons.eco,
      },
      {
        'title': 'Heritage',
        'description':
            'Preserving cultural traditions while embracing contemporary design.',
        'icon': Icons.history,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.ivory,
      child: Column(
        children: [
          Text(
            'Our Values',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ).animate().fadeIn().shimmer(delay: 2.seconds, duration: 2.seconds),
          SizedBox(height: isMobile ? 40 : 60),

          // Values Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: isMobile ? 16 : 32,
              mainAxisSpacing: isMobile ? 16 : 32,
              childAspectRatio: isMobile ? 1.5 : 1.2,
            ),
            itemCount: values.length,
            itemBuilder: (context, index) {
              final value = values[index];
              return _buildValueCard(
                title: value['title'] as String,
                description: value['description'] as String,
                icon: value['icon'] as IconData,
                isMobile: isMobile,
              )
                  .animate()
                  .fadeIn(delay: (index * 150).ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0);
            },
          ),
        ],
      ),
    );
  }

  /// Individual Value Card
  Widget _buildValueCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isMobile,
  }) {
    return _InteractableCard(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                color: AppColors.gold,
                size: 28,
              ),
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 12 : 13,
                color: AppColors.mediumBrown,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractableCard extends StatefulWidget {
  final Widget child;
  const _InteractableCard({required this.child});

  @override
  State<_InteractableCard> createState() => _InteractableCardState();
}

class _InteractableCardState extends State<_InteractableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}
