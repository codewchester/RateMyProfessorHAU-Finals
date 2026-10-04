import 'package:flutter/material.dart';
import '../models/review.dart';
import '../theme.dart';
import 'star_display.dart';

/// One review, shown on the Reviews Page (a professor's reviews from
/// everyone) and the Profile Page (a student's own reviews).
/// Takes only data and callbacks - no state of its own.
class ReviewCard extends StatelessWidget {
  final Review review;
  final VoidCallback? onTap;
  final VoidCallback? onFlag;
  final bool showFlag;

  const ReviewCard({
    super.key,
    required this.review,
    this.onTap,
    this.onFlag,
    this.showFlag = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFEDEDED),
                    child: Icon(Icons.person, size: 18, color: Color(0xFF757575)),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review.reviewerName, style: textTheme.labelLarge),
                        StarDisplay(rating: review.overallRating, showValue: false),
                      ],
                    ),
                  ),
                  Text(review.timestamp, style: textTheme.labelSmall),
                  if (showFlag)
                    IconButton(
                      icon: const Icon(Icons.flag_outlined, size: 18),
                      color: const Color(0xFF757575),
                      onPressed: onFlag,
                      tooltip: 'Report this review',
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Course: ${review.courseCode}',
                style: textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(review.comment, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
