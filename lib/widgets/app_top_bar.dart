import 'package:flutter/material.dart';

/// The "RateMyProfessorHAU" app bar with its wordmark and a search icon
/// action, repeated across the Course, Reviews, Profile, and Form
/// screens per the mockup.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchTap;

  const AppTopBar({super.key, this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 250, width: 250),
          const SizedBox(width: 6),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 20),
              onPressed: onSearchTap,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
