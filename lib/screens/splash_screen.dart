import 'package:flutter/material.dart';

import '../widgets/cosmic_background.dart';
import 'builder_screen.dart';
import 'date_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _exploreDate() {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => const DateSelectionScreen(),
    ),
  );
}

  void _meetBuilder() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const BuilderScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        imageUrl:
            'https://images-assets.nasa.gov/image/PIA12348/PIA12348~medium.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.92,
                        end: 1.05,
                      ).animate(_animationController),
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFB7C5FF)
                              .withValues(alpha: 0.18),
                          border: Border.all(
                            color: const Color(0xFFDFE5FF)
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'ASTERIA',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.3,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'Asteria',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 54),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your date. Your universe.',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        color: const Color(0xFFD9DFFE),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Discover what NASA captured on a date that matters to you.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: _exploreDate,
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                    ),
                    label: const Text('Explore a Date'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFB9C6FF),
                      foregroundColor: const Color(0xFF111B3A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: _meetBuilder,
                    icon: const Icon(
                      Icons.person_outline_rounded,
                    ),
                    label: const Text('Meet the Builder'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF4F5FB),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
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