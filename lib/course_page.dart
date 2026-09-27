import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../theme.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/professor_card.dart';

// Sample data for now. This will come from Firestore once the
// storage decision (see Proposal v2) is actually wired up.
const List<Professor> _sampleProfessors = [
  Professor(
    name: 'Dr. Santos',
    department: 'Computer Science',
    rating: 4.6,
    reviewCount: 42,
    tags: ['Clear grader', 'Engaging'],
  ),
  Professor(
    name: 'Prof. Reyes',
    department: 'Computer Science',
    rating: 3.9,
    reviewCount: 18,
    tags: ['Tough grader', 'Efficient'],
  ),
  Professor(
    name: 'Dr. Cruz',
    department: 'Computer Science',
    rating: 4.2,
    reviewCount: 27,
    tags: ['Fun', 'Feedback'],
  ),
];

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String _query = '';
  int _navIndex = 0;

  List<Professor> get _filteredProfessors {
    if (_query.isEmpty) return _sampleProfessors;
    return _sampleProfessors
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSearchBar(
              hintText: 'Search professor or course',
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('CS101 · Data Structures', style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProfessors.length,
                itemBuilder: (context, index) {
                  final professor = _filteredProfessors[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: ProfessorCard(
                      professor: professor,
                      onTap: () {
                        // Will navigate to the Reviews Page once it exists.
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
    );
  }
}
