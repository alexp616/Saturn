class Assignment {
  String due;
  String name;
  num? score;
  num points;
  String category;
  bool graded;

  Assignment(this.due, this.name, this.score, this.points, this.category, this.graded);

  factory Assignment.fromJson(dynamic json) {
    return Assignment(
      json['due'] as String,
      json['name'] as String,
      json['score'] as num?,
      json['points'] as num,
      json['category'] as String,
      json['graded'] as bool
    );
  }

  String toString() {
    if (score == null) {
      return '$name: Not Graded';
    }
    return '$name: $score / $points';
  }
}