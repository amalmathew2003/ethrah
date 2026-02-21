import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color gold = Color(0xFFD4A574);
  static const Color darkGold = Color(0xFFC99A60);
  static const Color lightGold = Color(0xFFE8C9A0);

  // Neutral Palette
  static const Color ivory = Color(0xFFFCF8F3);
  static const Color cream = Color(0xFFFBF7F0);
  static const Color beige = Color(0xFFF5EDE3);
  static const Color lightBeige = Color(0xFFFAF7F2);

  // Brown Tones
  static const Color darkBrown = Color(0xFF3D3D3D);
  static const Color mediumBrown = Color(0xFF6B6B6B);
  static const Color lightBrown = Color(0xFF8B8B8B);
  static const Color darkBeige = Color(0xFF8B7D6B);

  // Functional Colors
  static const Color border = Color(0xFFE8E0D8);
  static const Color lightBorder = Color(0xFFF0E8E0);
  static const Color shadow = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Overlay/Transparency
  static Color shadowOverlay = const Color(0xFF000000).withValues(alpha: 0.08);
  static Color darkOverlay = const Color(0xFF000000).withValues(alpha: 0.4);
  static Color lightOverlay = const Color(0xFF000000).withValues(alpha: 0.05);
}
