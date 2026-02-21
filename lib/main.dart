import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/app_colors.dart';
import 'config/app_routes.dart';

void main() {
  runApp(const EthrahApp());
}

class EthrahApp extends StatelessWidget {
  const EthrahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethrah - Where Elegance Meets Tradition',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.light,
          primary: AppColors.gold,
          secondary: AppColors.darkBeige,
          surface: AppColors.ivory,
          onSurface: AppColors.darkBrown,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 64,
            fontWeight: FontWeight.w700,
            color: AppColors.darkBrown,
            letterSpacing: -1.5,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            fontSize: 48,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
            letterSpacing: -0.5,
          ),
          displaySmall: GoogleFonts.playfairDisplay(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
          headlineLarge: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
          headlineMedium: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
          headlineSmall: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.darkBrown,
            height: 1.6,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.darkBrown,
            height: 1.5,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.mediumBrown,
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
            letterSpacing: 0.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkBrown,
            side: const BorderSide(color: AppColors.gold, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        scaffoldBackgroundColor: AppColors.cream,
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
