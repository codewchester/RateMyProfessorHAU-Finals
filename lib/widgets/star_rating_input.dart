import 'package:flutter/material.dart';
import '../theme.dart';

/// One labeled row of tappable stars, e.g. "Teaching Quality: stars".
/// This is the piece flagged as a risk in Proposal v2 (multi-category
/// ratings): built here as its own small component so the Form Page can
/// repeat it across all eight categories without duplicating star logic.
/// Takes the current value and a callback - the parent screen owns the
/// actual rating state.
class StarRatingInput extends StatelessWidget {
  final String label;
  final String? subtitle;
  final double rating; // whole-star only for this first version, 0-5
  final ValueChanged<double> onChanged;

  const StarRatingInput({
    super.key,
    required this.label,
    this.subtitle,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(subtitle!, style: Theme.of(context).textTheme.labelSmall),
                  ),
              ],
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              final starValue = index + 1;
              final filled = starValue <= rating;
              return IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: const Color(0xFFF5A623),
                  size: 20,
                ),
                onPressed: () => onChanged(starValue.toDouble()),
              );
            }),
          ),
        ],
      ),
    );
  }
}
