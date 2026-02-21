import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        _buildLogo(context)
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.2, end: 0),
        const Spacer(),
        Row(
          children: _navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _buildNavLink(
              context,
              label: item['label']!,
              route: item['route']!,
            )
                .animate()
                .fadeIn(delay: (index * 100).ms, duration: 400.ms)
                .slideY(begin: -0.2, end: 0);
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
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  _isMenuOpen ? Icons.close : Icons.menu,
                  key: ValueKey<bool>(_isMenuOpen),
                  color: AppColors.darkBrown,
                ),
              ),
            ),
          ],
        ),
        if (_isMenuOpen) ...[
          const SizedBox(height: 16),
          Column(
            children: _navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildMobileNavLink(
                context,
                label: item['label']!,
                route: item['route']!,
              )
                  .animate()
                  .fadeIn(delay: (index * 50).ms)
                  .slideX(begin: 0.1, end: 0);
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

    return _NavLink(
      label: label,
      isActive: isActive,
      onTap: () {
        if (widget.currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
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

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: (widget.isActive || _isHovered)
                      ? AppColors.gold
                      : AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1.5,
                width: (widget.isActive || _isHovered) ? 24 : 0,
                color: AppColors.gold,
                curve: Curves.easeOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
