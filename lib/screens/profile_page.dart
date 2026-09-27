import 'package:flutter/material.dart';
import '../models/review.dart';
import '../theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/review_card.dart';
import '../widgets/secondary_button.dart';

// Sample data standing in for Firebase Auth + a Firestore query filtered
// to the current student's authorId. No backend wired up yet (see
// README "Known issues").
const String _sampleStudentName = 'Juan Dela Cruz';
const String _sampleStudentEmail = 'juan.delacruz@hau.edu.ph';

const List<Review> _sampleMyReviews = [
  Review(
    professorName: 'Dr. Santos',
    teachingQuality: 5,
    workload: 4,
    gradingFairness: 5,
    comment: 'Clear grader, gives feedback fast.',
    timestamp: '2 days ago',
  ),
  Review(
    professorName: 'Prof. Reyes',
    teachingQuality: 3,
    workload: 3,
    gradingFairness: 4,
    comment: 'Tough grader but explains topics well.',
    timestamp: '1 week ago',
  ),
];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _navIndex = 2; // Profile tab

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student info
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    _sampleStudentName[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_sampleStudentName, style: textTheme.titleLarge),
                      Text(_sampleStudentEmail, style: textTheme.labelSmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            Text('My Reviews', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),

            Expanded(
              child: _sampleMyReviews.isEmpty
                  ? Center(
                      child: Text(
                        "You haven't submitted any reviews yet.",
                        style: textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _sampleMyReviews.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                          child: ReviewCard(review: _sampleMyReviews[index]),
                        );
                      },
                    ),
            ),

            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: 'LOGOUT',
              onPressed: () {
                // Will sign out of Firebase Auth once it's wired up.
              },
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
