import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_input_field.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/star_rating_input.dart';

/// Submit a review for a professor, rating them across three categories
/// (teaching quality, workload, grading fairness) plus a written comment.
///
/// This screen is the prototype for the item flagged as a risk in
/// Proposal v2: "multi-category ratings ... several repeated rating
/// inputs bound to state." Built here with three StarRatingInput rows,
/// each bound to its own state variable in this screen (the component
/// itself holds no state - see star_rating_input.dart).
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _professorController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  double _teachingQuality = 0;
  double _workload = 0;
  double _gradingFairness = 0;
  int _navIndex = 3; // Review tab

  @override
  void dispose() {
    _professorController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    final professorName = _professorController.text.trim();

    if (professorName.isEmpty ||
        _teachingQuality == 0 ||
        _workload == 0 ||
        _gradingFairness == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in the professor name and every rating.'),
        ),
      );
      return;
    }

    // TODO: once Firebase is wired up, this is where the review document
    // gets written to Firestore (see Proposal v2, "What I save,
    // concretely"). For now this just clears the form.
    setState(() {
      _professorController.clear();
      _commentController.clear();
      _teachingQuality = 0;
      _workload = 0;
      _gradingFairness = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Review submitted (not saved yet - no backend).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit a Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInputField(
              label: 'Professor name',
              controller: _professorController,
            ),
            const SizedBox(height: AppSpacing.sm),

            Text(
              'Rate this professor',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),

            StarRatingInput(
              label: 'Teaching Quality',
              rating: _teachingQuality,
              onChanged: (value) => setState(() => _teachingQuality = value),
            ),
            StarRatingInput(
              label: 'Workload',
              rating: _workload,
              onChanged: (value) => setState(() => _workload = value),
            ),
            StarRatingInput(
              label: 'Grading Fairness',
              rating: _gradingFairness,
              onChanged: (value) => setState(() => _gradingFairness = value),
            ),
            const SizedBox(height: AppSpacing.sm),

            AppInputField(
              label: 'Write your review',
              controller: _commentController,
              maxLines: 4,
            ),
            const SizedBox(height: AppSpacing.md),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submit,
                child: const Text('SUBMIT REVIEW'),
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
