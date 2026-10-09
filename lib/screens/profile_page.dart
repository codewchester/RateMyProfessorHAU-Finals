import 'package:flutter/material.dart';
import '../models/professor.dart';
import '../models/review.dart';
import '../theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/review_card.dart';

// Sample data standing in for Firebase Auth + a Firestore query filtered
// to the current student's authorId. No backend wired up yet.
const String _sampleStudentName = 'Juan Dela Cruz';
const String _sampleStudentDetails = '2nd Year · School of Computing';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _handleNav(BuildContext context, AppNavDestination destination) {
    switch (destination) {
      case AppNavDestination.settings:
        Navigator.of(context).pushNamed('/settings');
        break;
      case AppNavDestination.home:
      case AppNavDestination.professors:
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        break;
      case AppNavDestination.profile:
        // Already here.
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
    final myReviews =
        sampleReviews.where((r) => r.reviewerName == _sampleStudentName).toList();
    // Courses the student is enrolled in - standing in for real
    // enrollment data, which this app does not track yet.
    final myCourses = <String>{
      for (final p in sampleProfessors) ...p.courses,
    }.take(3).toList();
    // Favorites - no favoriting feature built yet, so this is empty on
    // purpose rather than faked.
    const myFavorites = <Professor>[];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const AppTopBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
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
                        Text(_sampleStudentName,
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(_sampleStudentDetails,
                            style: Theme.of(context).textTheme.labelSmall),
                        Text('${myReviews.length} Reviews',
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/edit-profile'),
                    child: const Text('Edit'),
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
                Tab(text: 'Favorites'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Ratings tab - the student's own submitted reviews
                  myReviews.isEmpty
                      ? const Center(child: Text("You haven't submitted any reviews yet."))
                      : ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          itemCount: myReviews.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                            child: ReviewCard(review: myReviews[index], showFlag: false),
                          ),
                        ),

                  // Courses tab
                  myCourses.isEmpty
                      ? const Center(child: Text('No enrolled courses yet.'))
                      : ListView(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          children: myCourses
                              .map((course) => Card(
                                    child: ListTile(
                                      leading: const Icon(Icons.menu_book),
                                      title: Text(course),
                                    ),
                                  ))
                              .toList(),
                        ),

                  // Favorites tab
                  myFavorites.isEmpty
                      ? const Center(
                          child: Text(
                            'No favorites yet.\n(Favoriting is not built yet.)',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox.shrink(),
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
          current: AppNavDestination.profile,
          onDestinationSelected: (d) => _handleNav(context, d),
        ),
      ),
    );
  }
}
