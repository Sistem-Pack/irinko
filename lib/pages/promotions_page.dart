import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irinko/utils/app_colors.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "АКЦИИ",
          style: GoogleFonts.montserrat(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.percent, size: 80, color: AppColors.accent.withOpacity(0.5)),
            const SizedBox(height: 24),
            Text(
              "Наши специальные предложения",
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Скоро здесь появятся самые сладкие скидки!",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: AppColors.primary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
