class TeacherModel {
  // String? key;
  String name;
  String specialty;

  TeacherModel({
    // this.key,
    required this.name,
    required this.specialty
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
      // key: json["key"],
      name: json["name"] as String,
      specialty: json["specialty"] as String,
  );

  Map<String, dynamic> get toJson => {
    // "key": key,
    "name": name,
    "specialty": specialty
  };
}
