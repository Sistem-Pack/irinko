import 'dart:math' as math;
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
      routes: {'/about': (context) => const AboutPage()},
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
        children: /*[
          PageView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Stack(children: [_buildHeroText(context), _buildHeroImage()]),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const _PopularitySection(),
                    const SizedBox(height: 100),
                    const _FooterSection(),
                  ],
                ),
              ),
            ],
          ),
          const _FixedHeader(),
          const _SnowEffect(),
        ],*/ [
          SingleChildScrollView(
            child: Column(
              children: [
                // 1. Hero Section
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Stack(children: [_buildHeroText(context), _buildHeroImage()]),
                ),

                const _PopularitySection(),

                const SizedBox(height: 100),

                // 3. Футер
                const _FooterSection(),
              ],
            ),
          ),

          const _FixedHeader(),

          const _SnowEffect(),
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
              child: Opacity(opacity: (1.0 + value).clamp(0.0, 1.0), child: child),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
            child: Opacity(opacity: (1.0 - value).clamp(0.0, 1.0), child: child),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(right: 60),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/images/cupcake_1.png",
                width: 450,
                height: 650,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 100, color: Colors.brown),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SnowEffect extends StatefulWidget {
  const _SnowEffect();

  @override
  State<_SnowEffect> createState() => _SnowEffectState();
}

class _SnowEffectState extends State<_SnowEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Snowflake> _snowflakes = List.generate(100, (index) => _Snowflake());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          for (var snowflake in _snowflakes) {
            snowflake.update();
          }
          return CustomPaint(painter: _SnowPainter(_snowflakes), size: Size.infinite);
        },
      ),
    );
  }
}

class _Snowflake {
  double x = math.Random().nextDouble();
  double y = math.Random().nextDouble();
  double radius = math.Random().nextDouble() * 2 + 1;
  double speed = math.Random().nextDouble() * 0.002 + 0.0005;
  double drift = math.Random().nextDouble() * 0.001 - 0.0005;

  void update() {
    y += speed;
    x += drift;
    if (y > 1.1) {
      y = -0.1;
      x = math.Random().nextDouble();
    }
    if (x > 1.1) x = -0.1;
    if (x < -0.1) x = 1.1;
  }
}

class _SnowPainter extends CustomPainter {
  final List<_Snowflake> snowflakes;

  _SnowPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);
    for (var snowflake in snowflakes) {
      canvas.drawCircle(
        Offset(snowflake.x * size.width, snowflake.y * size.height),
        snowflake.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
          return Transform.translate(offset: Offset(0, value), child: child);
        },
        child: Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      "IRINKO",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Sweets",
                        style: GoogleFonts.dancingScript(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary.withOpacity(0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      _HeaderLink(text: "ГЛАВНАЯ"),
                      SizedBox(width: 30),
                      _HeaderLink(text: "МЕНЮ"),
                      SizedBox(width: 30),
                      _HeaderLink(text: "О НАС", targetPage: AboutPage()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularitySection extends StatefulWidget {
  const _PopularitySection();

  @override
  State<_PopularitySection> createState() => _PopularitySectionState();
}

class _PopularitySectionState extends State<_PopularitySection> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _canScroll = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollOffset.value = _scrollController.offset;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        setState(() {
          _canScroll.value = _scrollController.position.maxScrollExtent > 10;
        });
      }
    });
  }

  void _scroll(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            "Популярное",
            style: GoogleFonts.playfairDisplay(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 40),
        ValueListenableBuilder<bool>(
          valueListenable: _canScroll,
          builder: (context, canScroll, child) {
            return SizedBox(
              height: 450,
              child: Row(
                children: [
                  // Левая кнопка (только если есть скролл)
                  if (canScroll)
                    ValueListenableBuilder<double>(
                      valueListenable: _scrollOffset,
                      builder: (context, offset, child) {
                        return Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: offset > 10,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: _ScrollButton(
                              icon: Icons.chevron_left,
                              onPressed: () => _scroll(-350),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // Зазор, чтобы в сумме (40+56+4) было ровно 100
                  if (canScroll) const SizedBox(width: 4),

                  // Область со списком (строго между кнопками)
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      // Если скролла нет, возвращаем отступ 100 для выравнивания
                      padding: EdgeInsets.symmetric(horizontal: canScroll ? 0 : 100),
                      itemCount: 8,
                      separatorBuilder: (context, index) => const SizedBox(width: 30),
                      itemBuilder: (context, index) {
                        final items = [
                          {
                            "name": "Набор Шоколадных Конфет",
                            "price": "1 200 ₽",
                            "image": "assets/images/placeholders/placeholder_main_card.jpg",
                          },
                          {
                            "name": "Набор Макарун",
                            "price": "1 500 ₽",
                            "image": "assets/images/products/kits/sweet_kit_1.jpg",
                          },
                          {
                            "name": "Трюфели ручной работы",
                            "price": "1 800 ₽",
                            "image": "assets/images/products/bluberry_cup.jpg",
                          },
                          {
                            "name": "Набор Шоколадных Конфет2",
                            "price": "1 200 ₽",
                            "image": "assets/images/products/whoopey_cake.jpg",
                          },
                          {
                            "name": "Набор Макарун2",
                            "price": "1 500 ₽",
                            "image": "assets/images/products/whoopey_cupcake.jpg",
                          },
                          {
                            "name": "Трюфели ручной работы2",
                            "price": "1 800 ₽",
                            "image": "assets/images/products/whoopey_cupcake_2.jpg",
                          },
                          {
                            "name": "Трюфели ручной работы2",
                            "price": "1 800 ₽",
                            "image": "assets/images/products/kits/buckets/bucket_chokolate.png",
                          },
                          {
                            "name": "Трюфели ручной работы2",
                            "price": "1 800 ₽",
                            "image": "assets/images/products/kits/champain.jpg",
                          },
                        ];
                        return _ProductCard(
                          name: items[index]["name"]!,
                          price: items[index]["price"]!,
                          imagePath: items[index]["image"]!,
                          index: index,
                        );
                      },
                    ),
                  ),

                  if (canScroll) const SizedBox(width: 4),

                  // Правая кнопка
                  if (canScroll)
                    ValueListenableBuilder<double>(
                      valueListenable: _scrollOffset,
                      builder: (context, offset, child) {
                        bool isAtEnd = false;
                        if (_scrollController.hasClients) {
                          isAtEnd = offset >= _scrollController.position.maxScrollExtent - 10;
                        }
                        return Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: !isAtEnd,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40, left: 4),
                            child: _ScrollButton(
                              icon: Icons.chevron_right,
                              onPressed: () => _scroll(350),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollOffset.dispose();
    _canScroll.dispose();
    super.dispose();
  }
}

class _ScrollButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;

  const _ScrollButton({required this.icon, required this.onPressed, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 450,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 15, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          onTap: onPressed,
          child: Icon(icon, color: AppColors.primary, size: 32),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final int index;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.index,
  });

  void _showProductDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(color: AppColors.shadow, blurRadius: 30, offset: const Offset(0, 15)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "О наборе",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.1)),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.cake, size: 80, color: Colors.brown),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Состав: натуральный бельгийский шоколад, свежие сливки, фруктовое пюре, дробленый фундук и капелька любви.",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.primary.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("В КОРЗИНУ"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + (index * 150)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GestureDetector(
        onTap: () => _showProductDetails(context),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: 320,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: AppColors.shadow, blurRadius: 15, offset: const Offset(0, 4)),
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
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.cake, size: 60, color: Colors.brown),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        price,
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "IRINKO",
                      style: TextStyle(
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
            "© 2026 IRINKO Sweets. Все права защищены.",
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
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: item.target != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item.target!),
                      );
                    }
                  : null,
              child: Text(
                item.text,
                style: GoogleFonts.montserrat(
                  color: AppColors.background.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
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
      onTap: targetPage != null
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage!));
            }
          : null,
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
