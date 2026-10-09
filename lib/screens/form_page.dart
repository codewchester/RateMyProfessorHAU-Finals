import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../models/review.dart';
import '../theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/star_rating_input.dart';

/// Submit a review for a professor, rating them across all eight
/// categories from the mockup, plus a written comment. If a [Professor]
/// is passed as the route argument (e.g. from the Reviews Page's "Write
/// a review" button), the professor field is pre-filled.
///
/// This screen is the full build-out of the item flagged as a risk in
/// Proposal v2: "multi-category ratings ... several repeated rating
/// inputs bound to state." Each of the eight StarRatingInput rows is
/// bound to its own entry in a single ratings map, held as state in this
/// screen (the component itself holds no state).
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _professorController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  Professor? _selectedProfessor;
  bool _showProfessorResults = false;

  String _courseCode = sampleProfessors.first.courses.isNotEmpty
      ? sampleProfessors.first.courses.first
      : '6ADMATHS';

  // One rating per category, starting unrated (0).
  final Map<String, double> _ratings = {
    for (final category in reviewCategories) category: 0,
  };

  bool _prefilled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_prefilled) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Professor) {
        _selectedProfessor = args;
        _professorController.text = args.name;
        if (args.courses.isNotEmpty) _courseCode = args.courses.first;
      }
      _prefilled = true;
    }
  }

  @override
  void dispose() {
    _professorController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _handleNav(AppNavDestination destination) {
    switch (destination) {
      case AppNavDestination.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      case AppNavDestination.home:
      case AppNavDestination.professors:
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case AppNavDestination.profile:
        Navigator.of(context).pushNamed('/profile');
        break;
      case AppNavDestination.review:
        Navigator.of(context).pushNamed('/reviews');
        break;
      case AppNavDestination.addReview:
        // The form is already open; keep the middle button on this page.
        break;
      default:
      // Fallback action for any unhandled destination
      break;
    }
  }

  void _submit() {
    final professorName = _professorController.text.trim();
    final anyUnrated = _ratings.values.any((v) => v == 0);

    if (professorName.isEmpty || anyUnrated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a professor and rate every category.'),
        ),
      );
      return;
    }

    // TODO: once Firebase is wired up, this is where the review document
    // (professor, course, per-category ratings, comment) gets written to
    // Firestore - see Proposal v2, "What I save, concretely".
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Review submitted'),
        content: const Text(
          'Thanks for your review! (Not saved yet - no backend connected.)',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final availableCourses = {
      for (final p in sampleProfessors) ...p.courses,
    }.toList();
    final courseOptions = _selectedProfessor?.courses.isNotEmpty == true
        ? _selectedProfessor!.courses
        : availableCourses;
    final professorQuery = _professorController.text.trim().toLowerCase();
    final matchingProfessors = sampleProfessors
        .where((professor) =>
            professorQuery.isEmpty ||
            professor.name.toLowerCase().contains(professorQuery))
        .toList();

    return Scaffold(
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Red "Form" banner
            Container(
              width: double.infinity,
              color: primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              alignment: Alignment.center,
              child: const Text(
                'Form',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFF5F5F5),
                        child: Icon(Icons.person, color: Color(0xFF1A1A1A)),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Text('Professor', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _professorController,
                    onChanged: (_) => setState(() {
                      _selectedProfessor = null;
                      _showProfessorResults = true;
                    }),
                    decoration: InputDecoration(
                      hintText: 'Search Professor',
                      prefixIcon: IconButton(
                        tooltip: 'Show professors',
                        icon: const Icon(Icons.search, size: 18),
                        onPressed: () => setState(
                          () => _showProfessorResults = !_showProfessorResults,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (_showProfessorResults) ...[
                    const SizedBox(height: 4),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 220),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: matchingProfessors.isEmpty
                          ? const ListTile(title: Text('No professors found.'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: matchingProfessors.length,
                              itemBuilder: (context, index) {
                                final professor = matchingProfessors[index];
                                return ListTile(
                                  leading: const Icon(Icons.school_outlined),
                                  title: Text(professor.name),
                                  subtitle: Text(professor.courses.join(' · ')),
                                  onTap: () {
                                    setState(() {
                                      _selectedProfessor = professor;
                                      _professorController.text = professor.name;
                                      if (professor.courses.isNotEmpty) {
                                        _courseCode = professor.courses.first;
                                      }
                                      _showProfessorResults = false;
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),

                  Row(
                    children: [
                      const Text('Course:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: courseOptions.contains(_courseCode)
                                ? _courseCode
                                : courseOptions.first,
                            dropdownColor: Colors.white,
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            items: courseOptions
                                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) setState(() => _courseCode = value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: AppSpacing.md),

                  Text('Review', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),

                  ...reviewCategories.map(
                    (category) => StarRatingInput(
                      label: category,
                      subtitle: reviewCategoryHelp[category],
                      rating: _ratings[category] ?? 0,
                      onChanged: (value) => setState(() => _ratings[category] = value),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),
                  Text('Additional Feedback', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text(
                    'What did you like and dislike about this professor? '
                    'Things to improve? Would you recommend?',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextField(
                    controller: _commentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'What I like and dislike about this professor is...',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppAddReviewFab(
        onPressed: () => _handleNav(AppNavDestination.addReview),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNav(
        current: AppNavDestination.addReview,
        onDestinationSelected: _handleNav,
      ),
    );
  }
}
