import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../theme.dart';

class AppSearchSelection {
  final Professor? professor;
  final String? course;

  const AppSearchSelection.professor(this.professor) : course = null;
  const AppSearchSelection.course(this.course) : professor = null;
}

class AppSearchDelegate extends SearchDelegate<AppSearchSelection?> {
  AppSearchDelegate() : super(searchFieldLabel: 'Search courses or professors');

  List<String> get _courses => {
        for (final professor in sampleProfessors) ...professor.courses,
      }.toList();

  List<Professor> get _matchingProfessors {
    final queryText = query.trim().toLowerCase();
    if (queryText.isEmpty) return sampleProfessors;
    return sampleProfessors
        .where((professor) => professor.name.toLowerCase().contains(queryText))
        .toList();
  }

  List<String> get _matchingCourses {
    final queryText = query.trim().toLowerCase();
    if (queryText.isEmpty) return _courses;
    return _courses
        .where((course) => course.toLowerCase().contains(queryText))
        .toList();
  }

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatches(context);

  @override
  Widget buildResults(BuildContext context) => _buildMatches(context);

  Widget _buildMatches(BuildContext context) {
    final professors = _matchingProfessors;
    final courses = _matchingCourses;
    if (professors.isEmpty && courses.isEmpty) {
      return const Center(child: Text('No matching courses or professors.'));
    }

    return ListView(
      children: [
        if (courses.isNotEmpty) ...[
          const _SearchSectionHeader('Courses'),
          for (final course in courses)
            ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(course),
              subtitle: const Text('View professors who teach this course'),
              onTap: () => close(context, AppSearchSelection.course(course)),
            ),
        ],
        if (professors.isNotEmpty) ...[
          const _SearchSectionHeader('Professors'),
          for (final professor in professors)
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: Text(professor.name),
              subtitle: Text(professor.courses.join(' · ')),
              onTap: () => close(
                context,
                AppSearchSelection.professor(professor),
              ),
            ),
        ],
      ],
    );
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        tooltip: 'Back',
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            tooltip: 'Clear search',
            icon: const Icon(Icons.clear),
            onPressed: () => query = '',
          ),
      ];
}

class _SearchSectionHeader extends StatelessWidget {
  final String title;

  const _SearchSectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(title, style: Theme.of(context).textTheme.titleSmall),
      );
}

/// Rounded search bar used at the top of the Course Page.
/// Takes a callback for text changes - it does not hold the search
/// state itself, the parent screen does.
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const AppSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
