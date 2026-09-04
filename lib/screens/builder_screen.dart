import 'package:flutter/material.dart';

import '../widgets/cosmic_background.dart';
import '../widgets/primary_button.dart';
import 'date_selection_screen.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _continue(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => const DateSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => _goBack(context),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                      label: const Text('Back to Asteria'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFD9DFFE),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'THE HUMAN BEHIND THE APP',
                      style: TextStyle(
                        color: Color(0xFFB7C5FF),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Meet the Builder',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 11),
                    Text(
                      'Every journey through the universe starts with a curious person.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1A2B4C),
                            Color(0xFF121D36),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5367B8)
                                .withValues(alpha: 0.12),
                            blurRadius: 30,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 88,
                                height: 88,
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFB7C5FF),
                                      Color(0xFFD8BEFF),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1A2644),
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    size: 40,
                                    color: Color(0xFFE7E9F5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sham',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Computer Science Student',
                                      style: TextStyle(
                                        color: Color(0xFFB7C5FF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Divider(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: 17),
                          Text(
                            'Asteria was created as a Flutter and API project—a simple way to connect meaningful dates with NASA’s view of the universe.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: const Color(0xFF172540),
                        borderRadius: BorderRadius.circular(21),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded,
                            color: Color(0xFFD8BEFF),
                          ),
                          SizedBox(width: 13),
                          Expanded(
                            child: Text(
                              'Built with curiosity, code, and a little help from the universe.',
                              style: TextStyle(
                                color: Color(0xFFE5E2F0),
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      label: 'Continue to Date Selection',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => _continue(context),
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