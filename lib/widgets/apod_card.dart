import 'package:flutter/material.dart';

import '../models/apod_model.dart';

class ApodCard extends StatelessWidget {
  const ApodCard({
    required this.apod,
    this.height = 390,
    this.showOverlay = true,
    super.key,
  });

  final ApodModel apod;
  final double height;
  final bool showOverlay;

  String get heroTag {
    return 'apod-${apod.date ?? apod.url ?? 'unknown'}';
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ApodMedia(apod: apod),
              if (showOverlay) ...[
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0x22050B18),
                        Color(0xF2050B18),
                      ],
                      stops: [0.35, 0.6, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 18,
                  left: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xDD10182C),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      apod.isVideo ? 'NASA · VIDEO' : 'NASA · APOD',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  right: 22,
                  bottom: 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apod.title ?? 'An unnamed cosmic moment',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (apod.date != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 14,
                              color: Color(0xFFB7C5FF),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              apod.date!,
                              style: const TextStyle(
                                color: Color(0xFFD9DFF1),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ApodMedia extends StatelessWidget {
  const ApodMedia({required this.apod, super.key});

  final ApodModel apod;

  @override
  Widget build(BuildContext context) {
    if (apod.hasImageUrl) {
      return Image.network(
        apod.url!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          }

          return const _MediaPlaceholder(
            icon: Icons.auto_awesome_rounded,
            title: 'Loading your universe…',
            message: 'The light is travelling to your screen.',
            showProgress: true,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const _MediaPlaceholder(
            icon: Icons.broken_image_rounded,
            title: 'The image drifted out of range',
            message: 'The NASA story is still available below.',
          );
        },
      );
    }

    if (apod.isVideo) {
      return const _MediaPlaceholder(
        icon: Icons.play_circle_outline_rounded,
        title: 'This APOD is a video',
        message: 'Open the details to find the NASA media link.',
      );
    }

    return const _MediaPlaceholder(
      icon: Icons.auto_awesome_rounded,
      title: 'No image was returned',
      message: 'NASA’s description is still available.',
    );
  }
}

class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder({
    required this.icon,
    required this.title,
    required this.message,
    this.showProgress = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF24385E), Color(0xFF151D38), Color(0xFF261B3B)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showProgress)
                const CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Color(0xFFB7C5FF),
                )
              else
                Icon(icon, size: 48, color: const Color(0xFFCDD5FF)),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 7),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
