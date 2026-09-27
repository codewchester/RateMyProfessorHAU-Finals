/// A professor as shown on the Course Page.
/// This is a plain data class for now; it will map onto a Firestore
/// document once the backend is wired up.
class Professor {
  final String name;
  final String department;
  final double rating;
  final int reviewCount;
  final List<String> tags;

  const Professor({
    required this.name,
    required this.department,
    required this.rating,
    required this.reviewCount,
    required this.tags,
  });
}
