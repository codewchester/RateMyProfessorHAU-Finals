/// A single submitted review.
/// Plain data class for now - this is what a Firestore `reviews` document
/// will map onto once the backend (see Proposal v2, "How my app saves
/// data") is wired up.
class Review {
  final String professorName;
  final double teachingQuality;
  final double workload;
  final double gradingFairness;
  final String comment;
  final String timestamp;

  const Review({
    required this.professorName,
    required this.teachingQuality,
    required this.workload,
    required this.gradingFairness,
    required this.comment,
    required this.timestamp,
  });

  /// Simple average of the three category ratings, for display as one
  /// overall star rating (e.g. on ProfessorCard / ReviewCard).
  double get overallRating =>
      (teachingQuality + workload + gradingFairness) / 3;
}
