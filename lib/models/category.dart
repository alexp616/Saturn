class Category {
  String name;
  num? grade;
  num weight;
  
  Category(this.name, this.grade, this.weight);

  factory Category.fromJson(dynamic json) {
    return Category(
      json['name'] as String,
      json['grade'] as num?,
      json['weight'] as num,
    );
  }
}