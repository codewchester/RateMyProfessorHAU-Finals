import 'package:flutter/material.dart';
import 'app_search_bar.dart';

/// The "RateMyProfessorHAU" app bar with its wordmark and a search icon
/// action, repeated across the Course, Reviews, Profile, and Form
/// screens per the mockup.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchTap;

  const AppTopBar({super.key, this.onSearchTap});

  Future<void> _openSearch(BuildContext context) async {
    if (onSearchTap != null) {
      onSearchTap!();
      return;
    }

    final selection = await showSearch<AppSearchSelection?>(
      context: context,
      delegate: AppSearchDelegate(),
    );
    if (!context.mounted || selection == null) return;

    if (selection.professor case final professor?) {
      Navigator.of(context).pushNamed('/reviews', arguments: professor);
    } else if (selection.course case final course?) {
      Navigator.of(context).pushNamed('/home', arguments: course);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 8,
      title: Row(
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/logo.png',
              height: 36,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
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
              onPressed: () => _openSearch(context),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
