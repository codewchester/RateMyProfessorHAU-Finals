import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../models/review.dart';
import '../theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/review_card.dart';
import '../widgets/star_display.dart';

/// The Reviews Screen (professor detail). Expects a [Professor] passed as
/// the route argument from the Course Page.
class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  void _handleNav(BuildContext context, AppNavDestination destination) {
    switch (destination) {
      case AppNavDestination.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      case AppNavDestination.home:
      case AppNavDestination.professors:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case AppNavDestination.profile:
        Navigator.of(context).pushNamed('/profile');
        break;
      case AppNavDestination.review:
        break;
      default:
      // Fallback action for any unhandled destination
      break;
    }
  }

  void _showReportDialog(BuildContext context) {
    // A dialog stands in for a dedicated "report" screen here, since the
    // action (flag one review) doesn't need a full page. No backend call
    // exists yet - this is a UI-only confirmation.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report this review'),
        content: const Text(
          'Let us know if this review violates community guidelines. '
          '(Reporting is not connected to a backend yet.)',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report submitted (not saved yet).')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showReviewDetail(BuildContext context, Review review) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.reviewerName,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Course: ${review.courseCode}'),
            const SizedBox(height: AppSpacing.xs),
            ...review.categoryRatings.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    StarDisplay(rating: entry.value, size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(review.comment),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final professor = args is Professor ? args : sampleProfessors.first;
    final primary = Theme.of(context).colorScheme.primary;

    final professorReviews =
        sampleReviews.where((r) => r.professorId == professor.id).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const AppTopBar(),
        body: Column(
          children: [
            // Red detail header
            Container(
              width: double.infinity,
              color: primary,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36, color: Color(0xFF1A1A1A)),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    professor.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    professor.department,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  StarDisplay(rating: professor.rating, size: 18, showValue: false),
                  Text(
                    '${professor.rating.toStringAsFixed(1)} · ${professor.reviewCount} reviews',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primary,
                      minimumSize: const Size(160, 40),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/form',
                      arguments: professor,
                    ),
                    child: const Text('Write a review'),
                  ),
                ],
              ),
            ),
            const TabBar(
              labelColor: Color(0xFFA6291E),
              unselectedLabelColor: Color(0xFF757575),
              indicatorColor: Color(0xFFA6291E),
              tabs: [
                Tab(text: 'Ratings'),
                Tab(text: 'Courses'),
                Tab(text: 'Details'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Ratings tab
                  professorReviews.isEmpty
                      ? const Center(child: Text('No reviews yet.'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          itemCount: professorReviews.length,
                          itemBuilder: (context, index) {
                            final review = professorReviews[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                              child: ReviewCard(
                                review: review,
                                onTap: () => _showReviewDetail(context, review),
                                onFlag: () => _showReportDialog(context),
                              ),
                            );
                          },
                        ),

                  // Courses tab
                  ListView(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    children: professor.courses
                        .map((course) => Card(
                              child: ListTile(
                                leading: const Icon(Icons.menu_book),
                                title: Text(course),
                              ),
                            ))
                        .toList(),
                  ),

                  // Details tab
                  ListView(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: Text(professor.email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(professor.officeLocation),
                      ),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text(professor.bio),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: AppAddReviewFab(
          onPressed: () => _handleNav(context, AppNavDestination.addReview),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNav(
          current: AppNavDestination.professors,
          onDestinationSelected: (d) => _handleNav(context, d),
        ),
      ),
    );
  }
}
