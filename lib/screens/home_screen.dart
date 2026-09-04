import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/apod_model.dart';
import '../widgets/apod_card.dart';
import '../widgets/cosmic_background.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.apod, required this.selectedDate, super.key});

  final ApodModel apod;
  final DateTime selectedDate;

  void _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => DetailsScreen(apod: apod)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final imageHeight = (width * 1.02).clamp(340.0, 470.0).toDouble();

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 34),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR COSMIC MOMENT',
                      style: TextStyle(
                        color: Color(0xFF9EADE0),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMMd().format(selectedDate),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 26),
                    ApodCard(apod: apod, height: imageHeight),
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111F38),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'THE STORY BEHIND THE IMAGE',
                            style: TextStyle(
                              color: Color(0xFFB9C4E2),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            apod.explanation ??
                                'NASA did not include an explanation.',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          TextButton.icon(
                            onPressed: () {
                              _openDetails(context);
                            },
                            label: const Text('Read the story'),
                            icon: const Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                        label: const Text('Explore another date'),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'Imagery and information courtesy of NASA APOD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7785A5),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
