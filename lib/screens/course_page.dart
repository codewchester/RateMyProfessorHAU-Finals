import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/professor_card.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String _courseQuery = '';
  String _department = 'ALL';

  // Sample departments for the filter dropdown. Will come from Firestore
  // once the backend is wired up.
  static const List<String> _departments = [
    'ALL',
    'School of Computing',
    'School of Business',
    'School of Engineering',
  ];

  List<Professor> get _filteredProfessors {
    return sampleProfessors.where((p) {
      final matchesDept = _department == 'ALL' || p.department == _department;
      final matchesQuery = _courseQuery.isEmpty ||
          p.courses.any((c) => c.toLowerCase().contains(_courseQuery.toLowerCase())) ||
          p.name.toLowerCase().contains(_courseQuery.toLowerCase());
      return matchesDept && matchesQuery;
    }).toList();
  }

  void _handleNav(AppNavDestination destination) {
    switch (destination) {
      case AppNavDestination.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      case AppNavDestination.home:
      case AppNavDestination.professors:
        // Already on the Course / Professors screen.
        break;
      case AppNavDestination.profile:
        Navigator.of(context).pushNamed('/profile');
        break;
      case AppNavDestination.review:
        Navigator.of(context).pushNamed('/reviews');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: const AppTopBar(),
      body: Column(
        children: [
          // Red header: heading + department dropdown + course search
          Container(
            width: double.infinity,
            color: primary,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _department,
                          icon: const Icon(Icons.arrow_drop_down, size: 18),
                          style: const TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 12,
                          ),
                          items: _departments
                              .map((d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(
                                      d == 'ALL' ? 'ALL' : d,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _department = value);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          onChanged: (value) => setState(() => _courseQuery = value),
                          decoration: const InputDecoration(
                            hintText: 'Search course',
                            hintStyle: TextStyle(fontSize: 13),
                            prefixIcon: Icon(Icons.search, size: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Professor grid
          Expanded(
            child: Container(
              color: primary,
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: _filteredProfessors.isEmpty
                  ? const Center(
                      child: Text(
                        'No professors match your search.',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.xs,
                        crossAxisSpacing: AppSpacing.xs,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: _filteredProfessors.length,
                      itemBuilder: (context, index) {
                        final professor = _filteredProfessors[index];
                        return ProfessorCard(
                          professor: professor,
                          onTap: () => Navigator.of(context).pushNamed(
                            '/reviews',
                            arguments: professor,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppAddReviewFab(
        onPressed: () => _handleNav(AppNavDestination.review),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNav(
        current: AppNavDestination.home,
        onDestinationSelected: _handleNav,
      ),
    );
  }
}
