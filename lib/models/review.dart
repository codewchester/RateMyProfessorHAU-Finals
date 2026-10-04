/// A single submitted review. Plain data class for now - this is what a
/// Firestore `reviews` document will map onto once the backend (see
/// Proposal v2, "How my app saves data") is wired up.
///
/// Ratings are keyed by category name so the Form Screen's eight
/// sub-categories (Teaching Effectiveness, Engagement & Enthusiasm,
/// Clarity of Communication, Fairness of Grading, Availability & Support,
/// Course Organization, Knowledge of Subject, Respect & Professionalism)
/// can all be stored without eight separate fields.
class Review {
  final String professorId;
  final String professorName;
  final String reviewerName;
  final String courseCode;
  final Map<String, double> categoryRatings;
  final String comment;
  final String timestamp;

  const Review({
    required this.professorId,
    required this.professorName,
    required this.reviewerName,
    required this.courseCode,
    required this.categoryRatings,
    required this.comment,
    required this.timestamp,
  });

  /// Average of every category rating, shown as one overall star value
  /// on ProfessorCard / ReviewCard.
  double get overallRating {
    if (categoryRatings.isEmpty) return 0;
    final total = categoryRatings.values.fold<double>(0, (a, b) => a + b);
    return total / categoryRatings.length;
  }
}

/// The eight rating categories from the Form Screen mockup, in the order
/// they should be displayed.
const List<String> reviewCategories = [
  'Teaching Effectiveness',
  'Engagement & Enthusiasm',
  'Clarity of Communication',
  'Fairness of Grading',
  'Availability & Support',
  'Course Organization',
  'Knowledge of Subject',
  'Respect & Professionalism',
];

/// One-line helper text shown under each category label on the Form
/// Screen, matching the mockup's descriptions.
const Map<String, String> reviewCategoryHelp = {
  'Teaching Effectiveness':
      'How well does the professor explain and help students understand the subject?',
  'Engagement & Enthusiasm':
      'Does the professor make the class interesting and keep students engaged?',
  'Clarity of Communication':
      'How clearly are lectures, instructions, and expectations delivered?',
  'Fairness of Grading':
      'Are grading policies transparent, consistent, and fair?',
  'Availability & Support':
      'Is the professor approachable and helpful outside of class (consultations, emails, etc.)?',
  'Course Organization':
      'Is the course structured logically with clear objectives, pacing, and materials?',
  'Knowledge of Subject':
      'Does the professor demonstrate strong expertise in the subject matter?',
  'Respect & Professionalism':
      'Does the professor treat students respectfully and maintain professionalism?',
};

// Sample data standing in for a Firestore query, filtered by professorId.
// No backend wired up yet (see README "Known issues").
const List<Review> sampleReviews = [
  Review(
    professorId: 'p4',
    professorName: 'Andrew G. Lee',
    reviewerName: 'Andrew G. Lee',
    courseCode: '6IASEC',
    categoryRatings: {
      'Teaching Effectiveness': 5,
      'Engagement & Enthusiasm': 5,
      'Clarity of Communication': 5,
      'Fairness of Grading': 5,
      'Availability & Support': 5,
      'Course Organization': 5,
      'Knowledge of Subject': 5,
      'Respect & Professionalism': 5,
    },
    comment: 'An engaging lecturer with deep understanding of psychology. '
        'Highly recommend!',
    timestamp: 'an hour ago',
  ),
  Review(
    professorId: 'p1',
    professorName: 'Dr. Maria Santos',
    reviewerName: 'Juan Dela Cruz',
    courseCode: '6ADMATHS',
    categoryRatings: {
      'Teaching Effectiveness': 5,
      'Engagement & Enthusiasm': 4,
      'Clarity of Communication': 5,
      'Fairness of Grading': 5,
      'Availability & Support': 4,
      'Course Organization': 4,
      'Knowledge of Subject': 5,
      'Respect & Professionalism': 5,
    },
    comment: 'Clear grader, gives feedback fast.',
    timestamp: '2 days ago',
  ),
  Review(
    professorId: 'p2',
    professorName: 'Prof. Antonio Reyes',
    reviewerName: 'Juan Dela Cruz',
    courseCode: '6ADMATHS',
    categoryRatings: {
      'Teaching Effectiveness': 3,
      'Engagement & Enthusiasm': 3,
      'Clarity of Communication': 3,
      'Fairness of Grading': 4,
      'Availability & Support': 3,
      'Course Organization': 3,
      'Knowledge of Subject': 4,
      'Respect & Professionalism': 4,
    },
    comment: 'Tough grader but explains topics well.',
    timestamp: '1 week ago',
  ),
];
