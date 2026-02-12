import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irinko/utils/app_colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          "О НАС",
          style: GoogleFonts.montserrat(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - value) * 30),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Наша история",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "IRINKO Sweets — это не просто кондитерская. Это семейное дело, рожденное из любви к настоящему шоколаду и эстетике десертов. Мы верим, что каждый кусочек должен приносить не только вкус, но и вдохновение.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            height: 1.8,
                            color: AppColors.primary.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Мы используем только натуральные ингредиенты: отборные какао-бобы, свежие сливки и ягоды. Каждый десерт создается вручную с особым вниманием к деталям.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            height: 1.8,
                            color: AppColors.primary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 100),
                Expanded(
                  flex: 1,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (value * 0.2),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        "https://picsum.photos/800/1000",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
