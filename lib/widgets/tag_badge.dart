import 'package:flutter/material.dart';

/// A small rounded label used for professor traits, e.g. "Clear grader".
/// Takes only data - no state of its own.
class TagBadge extends StatelessWidget {
  final String label;

  const TagBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
