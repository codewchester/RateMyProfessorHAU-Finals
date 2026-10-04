/// A professor, shown on the Course Page grid and the Reviews Page detail
/// header. Plain data class for now - this is what a Firestore
/// `professors` document will map onto once the backend is wired up
/// (see Proposal v2, "How my app saves data").
class Professor {
  final String id;
  final String name;
  final String department;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final List<String> courses;
  final String bio;
  final String email;
  final String officeLocation;
  final String? myReview; // null/None if the current student hasn't reviewed yet

  const Professor({
    required this.id,
    required this.name,
    required this.department,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    this.courses = const [],
    this.bio = '',
    this.email = '',
    this.officeLocation = '',
    this.myReview,
  });
}

// Sample data standing in for a Firestore query. No backend wired up yet
// (see README "Known issues").
const List<Professor> sampleProfessors = [
  Professor(
    id: 'p1',
    name: 'Dr. Maria Santos',
    department: 'School of Computing',
    rating: 4.3,
    reviewCount: 21,
    tags: ['Clear grader', 'Feedback', 'Engaging'],
    courses: ['6IASEC', '6ADMATHS'],
    bio: 'Teaches data structures and algorithms with a focus on real-world '
        'problem solving.',
    email: 'm.santos@hau.edu.ph',
    officeLocation: 'CCS Building, Room 204',
  ),
  Professor(
    id: 'p2',
    name: 'Prof. Antonio Reyes',
    department: 'School of Computing',
    rating: 3.9,
    reviewCount: 18,
    tags: ['Tough grader', 'Efficient'],
    courses: ['6ADMATHS'],
    bio: 'Focuses on discrete mathematics and proof-based reasoning.',
    email: 'a.reyes@hau.edu.ph',
    officeLocation: 'CCS Building, Room 110',
  ),
  Professor(
    id: 'p3',
    name: 'Dr. Liza Cruz',
    department: 'School of Computing',
    rating: 4.2,
    reviewCount: 27,
    tags: ['Fun', 'Engaging'],
    courses: ['6IASEC'],
    bio: 'Known for interactive lectures and project-based assessment.',
    email: 'l.cruz@hau.edu.ph',
    officeLocation: 'CCS Building, Room 301',
  ),
  Professor(
    id: 'p4',
    name: 'Prof. Andrew G. Lee',
    department: 'School of Computing',
    rating: 5.0,
    reviewCount: 125,
    tags: ['Clear grader', 'Feedback', 'Efficient', 'Engaging', 'Fun'],
    courses: ['6IASEC', '6ADMATHS'],
    bio: 'An engaging lecturer with deep understanding of psychology and '
        'how students learn technical material.',
    email: 'a.lee@hau.edu.ph',
    officeLocation: 'CCS Building, Room 215',
  ),
];
