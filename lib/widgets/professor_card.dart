import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../theme.dart';
import 'tag_badge.dart';

/// One professor result on the Course Page.
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // dark header band
            Container(
              height: 8,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(professor.name, style: textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text(professor.department, style: textTheme.labelSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
                      const SizedBox(width: 4),
                      Text(
                        '${professor.rating.toStringAsFixed(1)} '
                        '(${professor.reviewCount} reviews)',
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: professor.tags
                        .map((tag) => TagBadge(label: tag))
                        .toList(),
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
