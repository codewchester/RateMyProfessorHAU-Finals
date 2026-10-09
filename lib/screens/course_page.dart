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
  final TextEditingController _courseSearchController = TextEditingController();
  String _courseQuery = '';
  String _department = 'ALL';
  bool _initialQueryLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialQueryLoaded) return;
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is String) {
      _courseQuery = arguments;
      _courseSearchController.text = arguments;
    }
    _initialQueryLoaded = true;
  }

  @override
  void dispose() {
    _courseSearchController.dispose();
    super.dispose();
  }

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
      case AppNavDestination.addReview:
        Navigator.of(context).pushNamed('/form');
        break;
      default:
      // Fallback action for any unhandled destination
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;
    final isNarrowLayout = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: const AppTopBar(),
      body: Column(
        children: [
          // Page title
          Container(
            width: double.infinity,
            color: primary,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              18,
              AppSpacing.md,
              18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Find a professor by course or school.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),

          // Filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 148,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
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
                                  d == 'ALL' ? 'All schools' : d,
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
                  child: TextField(
                    controller: _courseSearchController,
                    onChanged: (value) => setState(() => _courseQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search course',
                      hintStyle: const TextStyle(fontSize: 13),
                      prefixIcon: const Icon(Icons.search, size: 18),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Professor results
          Expanded(
            child: Container(
              color: const Color(0xFFF7F5F4),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      children: [
                        const Text(
                          'Professors',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_filteredProfessors.length} found',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _filteredProfessors.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search_off, size: 36, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('No professors match your search.'),
                              ],
                            ),
                          )
                        : isNarrowLayout
                            ? ListView.separated(
                                itemCount: _filteredProfessors.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: AppSpacing.xs),
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
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: AppSpacing.xs,
                                  crossAxisSpacing: AppSpacing.xs,
                                  childAspectRatio: 0.86,
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
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AppAddReviewFab(
        onPressed: () => _handleNav(AppNavDestination.addReview),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNav(
        current: AppNavDestination.home,
        onDestinationSelected: _handleNav,
      ),
    );
  }
}
