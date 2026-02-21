import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';

/// Responsive navigation bar with logo and navigation links
class AppNavBar extends StatefulWidget {
  final String currentRoute;

  const AppNavBar({super.key, required this.currentRoute});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  bool _isMenuOpen = false;

  final List<Map<String, String>> _navItems = [
    {'label': 'Home', 'route': '/'},
    {'label': 'Collections', 'route': '/collections'},
    {'label': 'Gallery', 'route': '/gallery'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Contact', 'route': '/contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppColors.ivory,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 16 : 20,
      ),
      child: isMobile ? _buildMobileNav(context) : _buildDesktopNav(context),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      children: [
        _buildLogo(context),
        const Spacer(),
        Row(
          children: _navItems.map((item) {
            return _buildNavLink(
              context,
              label: item['label']!,
              route: item['route']!,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildLogo(context),
            const Spacer(),
            IconButton(
              onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
              icon: Icon(
                _isMenuOpen ? Icons.close : Icons.menu,
                color: AppColors.darkBrown,
              ),
            ),
          ],
        ),
        if (_isMenuOpen) ...[
          const SizedBox(height: 16),
          Column(
            children: _navItems.map((item) {
              return _buildMobileNavLink(
                context,
                label: item['label']!,
                route: item['route']!,
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.home),
      child: Text(
        'Ethrah',
        style: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.darkBrown,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildNavLink(
    BuildContext context, {
    required String label,
    required String route,
  }) {
    final isActive = widget.currentRoute == route;

    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: GestureDetector(
        onTap: () {
          if (widget.currentRoute != route) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.gold : AppColors.darkBrown,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(
                height: 1.5,
                width: 20,
                color: AppColors.gold,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(
    BuildContext context, {
    required String label,
    required String route,
  }) {
    final isActive = widget.currentRoute == route;

    return GestureDetector(
      onTap: () {
        setState(() => _isMenuOpen = false);
        if (widget.currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? AppColors.gold : AppColors.darkBrown,
          ),
        ),
      ),
    );
  }
}
