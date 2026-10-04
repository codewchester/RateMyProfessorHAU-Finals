import 'package:flutter/material.dart';

/// Shows a rating as filled/empty stars plus the numeric value. Read-only
/// - used on cards and detail headers. For the tappable version used on
/// the Form Screen, see star_rating_input.dart.
class StarDisplay extends StatelessWidget {
  final double rating; // 0-5
  final double size;
  final bool showValue;

  const StarDisplay({
    super.key,
    required this.rating,
    this.size = 16,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < fullStars ? Icons.star : Icons.star_border,
            size: size,
            color: const Color(0xFFF5A623),
          );
        }),
        if (showValue) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ],
    );
  }
}
