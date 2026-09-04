import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../services/api.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/date_selector.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key});

  @override
  State<DateSelectionScreen> createState() {
    return _DateSelectionScreenState();
  }
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  static final DateTime firstApodDate = DateTime(1995, 6, 16);

  final NASAApiService _apiService = NASAApiService();

  late DateTime _selectedDate;
  bool _isLoading = false;
  String? _errorMessage;

  DateTime get today {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = today;
  }

  @override
  void dispose() {
    _apiService.close();
    super.dispose();
  }

  void _goBackToAsteria() {
    Navigator.of(context).pop();
  }

  void _changeDate(DateTime date) {
    setState(() {
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
      );

      _errorMessage = null;
    });
  }

  Future<void> _chooseBirthday() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: firstApodDate,
      lastDate: today,
      helpText: 'WHEN IS YOUR BIRTHDAY?',
      confirmText: 'USE THIS DATE',
    );

    if (selected != null) {
      _changeDate(selected);
    }
  }

  void _chooseToday() {
    _changeDate(today);
  }

  void _chooseRandomDate() {
    final int numberOfDays =
        today.difference(firstApodDate).inDays;

    final int randomNumber =
        math.Random().nextInt(numberOfDays + 1);

    final DateTime randomDate = firstApodDate.add(
      Duration(days: randomNumber),
    );

    _changeDate(randomDate);
  }

  Future<void> _discover() async {
    if (_selectedDate.isBefore(firstApodDate) ||
        _selectedDate.isAfter(today)) {
      setState(() {
        _errorMessage =
            'Choose a date between June 16, 1995 and today.';
      });

      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apod = await _apiService.fetchApod(
        _selectedDate,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
      });

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => HomeScreen(
            apod: apod,
            selectedDate: _selectedDate,
          ),
        ),
      );
    } on NASAApiException catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = error.message;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage =
            'Something unexpected happened. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              24,
              30,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _goBackToAsteria,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                size: 20,
                                color: Color(0xFFD9DFFE),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Back to Asteria',
                                style: TextStyle(
                                  color: Color(0xFFD9DFFE),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFFB7C5FF),
                          size: 20,
                        ),
                        SizedBox(width: 9),
                        Text(
                          'ASTERIA',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Find Your\nCosmic Moment',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Pick a date. We’ll show you what NASA captured from the universe that day.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    const SizedBox(height: 32),
                    DateSelector(
                      selectedDate: _selectedDate,
                      firstDate: firstApodDate,
                      lastDate: today,
                      onDateChanged: _changeDate,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'QUICK PICKS',
                      style: TextStyle(
                        color: Color(0xFF96A4C7),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _QuickPick(
                          label: 'My Birthday',
                          icon: Icons.cake_outlined,
                          onPressed: _chooseBirthday,
                        ),
                        _QuickPick(
                          label: 'Today',
                          icon: Icons.today_outlined,
                          onPressed: _chooseToday,
                        ),
                        _QuickPick(
                          label: 'Random Date',
                          icon: Icons.shuffle_rounded,
                          onPressed: _chooseRandomDate,
                        ),
                      ],
                    ),
                    if (_isLoading) ...[
                      const SizedBox(height: 24),
                      const _LoadingCard(),
                    ],
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 24),
                      _ErrorCard(
                        message: _errorMessage!,
                        onRetry: _discover,
                      ),
                    ],
                    const SizedBox(height: 32),
                    PrimaryButton(
                      label: 'Discover',
                      icon: Icons.auto_awesome_rounded,
                      isLoading: _isLoading,
                      onPressed: _discover,
                    ),
                    const SizedBox(height: 14),
                    const Center(
                      child: Text(
                        'NASA APOD is available from June 16, 1995',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7F8BAA),
                          fontSize: 12,
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

class _QuickPick extends StatelessWidget {
  const _QuickPick({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      avatar: Icon(
        icon,
        size: 17,
        color: const Color(0xFFB7C5FF),
      ),
      label: Text(label),
      labelStyle: const TextStyle(
        color: Color(0xFFDCE1F0),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: const Color(0xFF14213A),
      side: BorderSide(
        color: Colors.white.withOpacity(0.08),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF14213B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFFB7C5FF),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Reaching across the universe…',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF362033),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFB4AB).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cosmic discovery couldn’t be loaded',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 7),
          Text(message),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}