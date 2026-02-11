import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 236, 211),
        body: Stack(
          children: [
            const Center(
              child: Text(
                'Irinko App',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.brown,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            
            Align(
              alignment: Alignment.centerRight,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.0, end: 0.0),
                duration: const Duration(milliseconds: 1200),
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
                  margin: const EdgeInsets.only(right: 30),
                  width: 250,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      'https://picsum.photos/500/800',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.white24,
                        child: const Icon(Icons.image, size: 50, color: Colors.brown),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
