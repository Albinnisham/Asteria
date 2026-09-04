import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/apod_model.dart';
import '../widgets/apod_card.dart';
import '../widgets/cosmic_background.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.apod, super.key});

  final ApodModel apod;

  String get prettyDate {
    final parsedDate = DateTime.tryParse(apod.date ?? '');

    if (parsedDate == null) {
      return apod.date ?? 'Date unavailable';
    }

    return DateFormat.yMMMMd().format(parsedDate);
  }

  Future<void> _showHdImage(BuildContext context) async {
    if (!apod.hasHdImage) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog.fullscreen(
          backgroundColor: const Color(0xFF071225),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Text(
                        'HD IMAGE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                Expanded(
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 5,
                    child: Center(
                      child: Image.network(
                        apod.hdUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) {
                            return child;
                          }

                          return const CircularProgressIndicator(
                            color: Color(0xFFB7C5FF),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Padding(
                            padding: EdgeInsets.all(30),
                            child: Text('The HD image could not be loaded.'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _copyVideoUrl(BuildContext context) async {
    if (apod.url == null) {
      return;
    }

    await Clipboard.setData(ClipboardData(text: apod.url!));

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('NASA media link copied.')));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final imageHeight = (width * 0.8).clamp(300.0, 480.0).toDouble();

    return Scaffold(
      body: CosmicBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Back',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'COSMIC DETAILS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ApodCard(
                        apod: apod,
                        height: imageHeight,
                        showOverlay: false,
                      ),
                      const SizedBox(height: 27),
                      Wrap(
                        spacing: 9,
                        runSpacing: 9,
                        children: [
                          const _InfoPill(
                            icon: Icons.auto_awesome_rounded,
                            label: 'NASA APOD',
                          ),
                          _InfoPill(
                            icon: apod.isVideo
                                ? Icons.play_arrow_rounded
                                : Icons.image_outlined,
                            label: (apod.mediaType ?? 'Unknown').toUpperCase(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        apod.title ?? 'An unnamed cosmic moment',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 11),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: Color(0xFF9EADE0),
                          ),
                          const SizedBox(width: 8),
                          Text(prettyDate),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Divider(color: Colors.white.withValues(alpha: 0.1)),
                      const SizedBox(height: 20),
                      Text(
                        'The story',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 13),
                      Text(
                        apod.explanation ??
                            'NASA did not include an explanation.',
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(height: 1.7),
                      ),
                      if (apod.hasHdImage) ...[
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showHdImage(context);
                            },
                            icon: const Icon(Icons.hd_rounded),
                            label: const Text('View HD image'),
                          ),
                        ),
                      ],
                      if (apod.isVideo && apod.url != null) ...[
                        const SizedBox(height: 28),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF172541),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NASA video link',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              SelectableText(
                                apod.url!,
                                style: const TextStyle(
                                  color: Color(0xFFABB8DD),
                                  fontSize: 12,
                                  height: 1.5,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  _copyVideoUrl(context);
                                },
                                icon: const Icon(Icons.copy_rounded),
                                label: const Text('Copy media link'),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Image and story provided by NASA’s Astronomy Picture of the Day.',
                          style: TextStyle(
                            color: Color(0xFF8995B2),
                            height: 1.5,
                          ),
                        ),
                      ),
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

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF182744),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFB7C5FF)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
