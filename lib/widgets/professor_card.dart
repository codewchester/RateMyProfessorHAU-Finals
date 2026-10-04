import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../theme.dart';
import 'tag_badge.dart';

/// One professor result, shown in the 2-column grid on the Course Page.
/// Takes data and a tap callback only - no setState here.
class ProfessorCard extends StatelessWidget {
  final Professor professor;
  final VoidCallback onTap;

  const ProfessorCard({
    super.key,
    required this.professor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // dark header band with a circular placeholder icon + label
            Container(
              width: double.infinity,
              color: onSurface,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Color(0xFF1A1A1A)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Professor',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  Text(
                    professor.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top Tags:', style: textTheme.labelSmall),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: professor.tags
                        .take(3)
                        .map((tag) => TagBadge(label: tag))
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'My Review: ${professor.myReview ?? "None"}',
                    style: textTheme.labelSmall,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Color(0xFFF5A623)),
                      const SizedBox(width: 4),
                      Text(
                        '${professor.rating.toStringAsFixed(1)} '
                        '(${professor.reviewCount} reviews)',
                        style: textTheme.labelSmall,
                      ),
                    ],
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
