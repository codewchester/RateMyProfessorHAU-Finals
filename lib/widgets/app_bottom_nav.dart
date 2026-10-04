import 'package:flutter/material.dart';

/// The bottom navigation used on Course, Reviews, and Profile screens,
/// matching the mockup: settings (gear), home, a floating plus button
/// (docked/notched, navigates to the Form Screen), professors, and
/// profile.
///
/// This widget only renders icons and reports which one was tapped via
/// [onDestinationSelected] - it does not navigate itself. The screen
/// that uses it owns the actual Navigator calls, same pattern as every
/// other component in this app (data and callbacks, not state).
enum AppNavDestination { settings, home, review, professors, profile, addReview }

class AppBottomNav extends StatelessWidget {
  final AppNavDestination current;
  final ValueChanged<AppNavDestination> onDestinationSelected;

  const AppBottomNav({
    super.key,
    required this.current,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    Widget navIcon(IconData icon, AppNavDestination destination) {
      final isActive = destination == current;
      return IconButton(
        icon: Icon(icon),
        color: isActive ? primary : Colors.grey,
        onPressed: () => onDestinationSelected(destination),
      );
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navIcon(Icons.settings, AppNavDestination.settings),
          navIcon(Icons.home, AppNavDestination.home),
          const SizedBox(width: 40), // space for the notched FAB
          navIcon(Icons.school, AppNavDestination.review),
          navIcon(Icons.person, AppNavDestination.profile),
        ],
      ),
    );
  }
}

/// The floating plus button docked into the notch, always navigating to
/// the Form Screen regardless of which screen it's shown on.
class AppAddReviewFab extends StatelessWidget {
  final VoidCallback onPressed;

  const AppAddReviewFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
