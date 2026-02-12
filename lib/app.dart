import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irinko/utils/app_colors.dart';
import 'package:irinko/pages/about_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // Добавляем маршруты, если понадобится в будущем
      routes: {
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 1. Hero Section
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      _buildHeroText(context),
                      _buildHeroImage(),
                    ],
                  ),
                ),

                // 2. Секция Меню
                const _MenuSection(),
                
                const SizedBox(height: 100),

                // 3. Футер
                const _FooterSection(),
              ],
            ),
          ),

          const _FixedHeader(),
        ],
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: -1.0, end: 0.0),
          duration: const Duration(milliseconds: 1400),
          curve: Curves.easeOutQuart,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value * 100, 0),
              child: Opacity(
                opacity: (1.0 + value).clamp(0.0, 1.0),
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Авторские\nдесерты",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Домашний шоколад который хочется подарить",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primary.withOpacity(0.8),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("СМОТРЕТЬ МЕНЮ"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Align(
      alignment: Alignment.centerRight,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        duration: const Duration(milliseconds: 1600),
        curve: Curves.easeOutQuint,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value * 150, 0),
            child: Opacity(
              opacity: (1.0 - value).clamp(0.0, 1.0),
              child: child,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(right: 60),
          child: Image.asset(
            "assets/images/cupcake_1.png",
            width: 450,
            height: 650,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 100, color: Colors.brown),
          ),
        ),
      ),
    );
  }
}

class _FixedHeader extends StatelessWidget {
  const _FixedHeader();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: -100.0, end: 0.0),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutExpo,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "IRINKO",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Sweets",
                    style: GoogleFonts.dancingScript(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  _HeaderLink(text: "ГЛАВНАЯ"),
                  SizedBox(width: 30),
                  _HeaderLink(text: "МЕНЮ"),
                  SizedBox(width: 30),
                  _HeaderLink(text: "О НАС", targetPage: AboutPage()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            "Наше Меню",
            style: GoogleFonts.playfairDisplay(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 450,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (context, index) => const SizedBox(width: 30),
            itemBuilder: (context, index) => _ProductCard(index: index),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final int index;
  const _ProductCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + (index * 150)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Container(
                  color: AppColors.accent.withOpacity(0.1),
                  width: double.infinity,
                  child: const Icon(Icons.cake, size: 60, color: Colors.brown),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Набор конфет #${index + 1}",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "1 200 ₽",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 100),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IRINKO",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sweets",
                    style: GoogleFonts.dancingScript(
                      fontSize: 32,
                      color: AppColors.background.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Создаем сладкие шедевры\nдля ваших особенных моментов.",
                    style: GoogleFonts.montserrat(
                      color: AppColors.background.withOpacity(0.6),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
              _buildFooterColumn(context, "НАВИГАЦИЯ", [
                _FooterLinkData("Главная"),
                _FooterLinkData("Меню"),
                _FooterLinkData("Доставка"),
                _FooterLinkData("О нас", target: const AboutPage()),
              ]),
              _buildFooterColumn(context, "КОНТАКТЫ", [
                _FooterLinkData("+7 (999) 000-00-00"),
                _FooterLinkData("hello@irinko.ru"),
                _FooterLinkData("г. Москва, ул. Примерная, 10"),
              ]),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: AppColors.background.withOpacity(0.1)),
          const SizedBox(height: 20),
          Text(
            "© 2023 IRINKO Sweets. Все права защищены.",
            style: GoogleFonts.montserrat(
              color: AppColors.background.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(BuildContext context, String title, List<_FooterLinkData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: item.target != null ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => item.target!));
            } : null,
            child: Text(
              item.text,
              style: GoogleFonts.montserrat(
                color: AppColors.background.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class _FooterLinkData {
  final String text;
  final Widget? target;
  _FooterLinkData(this.text, {this.target});
}

class _HeaderLink extends StatelessWidget {
  final String text;
  final Widget? targetPage;
  const _HeaderLink({required this.text, this.targetPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: targetPage != null ? () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage!));
      } : null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
