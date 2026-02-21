import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../data/dummy_data.dart';
import '../widgets/common/app_navbar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/common/custom_button.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully! We\'ll be in touch soon.'),
          backgroundColor: AppColors.gold,
          duration: Duration(seconds: 3),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
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
            const AppNavBar(currentRoute: '/contact'),

            // Header
            _buildHeader(isMobile),

            // Contact Section
            _buildContactSection(isMobile),

            // Map Section
            _buildMapSection(isMobile),

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
            'Get In Touch',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 48 : 64,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBrown,
              letterSpacing: -1,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'We\'d love to hear from you. Send us a message!',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.mediumBrown,
            ),
          ),
        ],
      ),
    );
  }

  /// Contact Section with Form and Information
  Widget _buildContactSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      color: AppColors.cream,
      child: isMobile
          ? Column(
              children: [
                _buildContactForm(isMobile),
                SizedBox(height: isMobile ? 40 : 60),
                _buildContactInfo(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildContactForm(isMobile),
                ),
                const SizedBox(width: 60),
                Expanded(
                  child: _buildContactInfo(isMobile),
                ),
              ],
            ),
    );
  }

  /// Contact Form
  Widget _buildContactForm(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: isMobile ? 24 : 32),

          // Name Field
          _buildFormField(
            label: 'Your Name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: isMobile ? 16 : 20),

          // Email Field
          _buildFormField(
            label: 'Email Address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: isMobile ? 16 : 20),

          // Message Field
          TextFormField(
            controller: _messageController,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: 'Your Message',
              labelStyle: GoogleFonts.poppins(
                color: AppColors.mediumBrown,
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors.ivory,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.gold,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            style: GoogleFonts.poppins(
              color: AppColors.darkBrown,
              fontSize: 14,
              height: 1.6,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          SizedBox(height: isMobile ? 24 : 32),

          // Submit Button
          PrimaryButton(
            text: 'Send Message',
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }

  /// Form Input Field
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: AppColors.mediumBrown,
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors.ivory,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.gold,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(14),
      ),
      style: GoogleFonts.poppins(
        color: AppColors.darkBrown,
        fontSize: 14,
      ),
      validator: validator,
    );
  }

  /// Contact Information
  Widget _buildContactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 28 : 32,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),

        // Contact Cards
        _buildContactCard(
          icon: Icons.email_outlined,
          title: 'Email',
          value: DummyData.brandInfo.email,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening email client...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        SizedBox(height: isMobile ? 16 : 20),

        _buildContactCard(
          icon: Icons.call_outlined,
          title: 'WhatsApp',
          value: DummyData.brandInfo.whatsappNumber,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening WhatsApp...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        SizedBox(height: isMobile ? 16 : 20),

        _buildContactCard(
          icon: Icons.camera_alt_outlined,
          title: 'Instagram',
          value: '@${DummyData.brandInfo.instagramHandle}',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening Instagram...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        SizedBox(height: isMobile ? 16 : 20),

        _buildContactCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: 'Thrissur, Kerala, India',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening Maps...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Individual Contact Card
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.ivory,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                color: AppColors.gold,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.gold,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  /// Map Section (Placeholder)
  Widget _buildMapSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 60,
      ),
      color: AppColors.ivory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find Us',
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: isMobile ? 20 : 24),

          // Map Placeholder
          Container(
            width: double.infinity,
            height: isMobile ? 300 : 400,
            decoration: BoxDecoration(
              color: AppColors.beige,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    size: 48,
                    color: AppColors.mediumBrown,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Google Map Placeholder',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.mediumBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thrissur, Kerala, India',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.lightBrown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
