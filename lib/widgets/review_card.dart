import 'package:flutter/material.dart';
import '../models/review.dart';
import '../theme.dart';

/// One review, shown on the Profile Page (a student's own reviews) and
/// later on the Reviews Page (a professor's reviews from everyone).
/// Takes only data - no state of its own.
class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // gray header band
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            color: const Color(0xFFEDEDED),
            child: Row(
              children: [
                Expanded(
                  child: Text(review.professorName, style: textTheme.labelLarge),
                ),
                Text(review.timestamp, style: textTheme.labelSmall),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
                    const SizedBox(width: 4),
                    Text(
                      '${review.overallRating.toStringAsFixed(1)} overall',
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(review.comment, style: textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
