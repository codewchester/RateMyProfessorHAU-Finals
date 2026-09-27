import 'package:flutter/material.dart';
import '../theme.dart';

/// One labeled row of tappable stars, e.g. "Teaching Quality: ★★★☆☆".
/// This is the piece flagged as a risk in Proposal v2 (multi-category
/// ratings): built here as its own small component so the Form Page can
/// repeat it three times without duplicating star logic.
/// Takes the current value and a callback - the parent screen owns the
/// actual rating state.
class StarRatingInput extends StatelessWidget {
  final String label;
  final double rating; // whole-star only for this first version, 0-5
  final ValueChanged<double> onChanged;

  const StarRatingInput({
    super.key,
    required this.label,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Row(
          children: List.generate(5, (index) {
            final starValue = index + 1;
            final filled = starValue <= rating;
            return IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              icon: Icon(
                filled ? Icons.star : Icons.star_border,
                color: const Color(0xFFF5A623),
                size: 22,
              ),
              onPressed: () => onChanged(starValue.toDouble()),
            );
          }),
        ),
      ],
    );
  }
}
