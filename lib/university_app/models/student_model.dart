class StudentModel {
  String name;
  int age;
  String email;

  StudentModel({
    // this.key,
    required this.email,
    required this.name,
    required this.age,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    email: json["email"],
    name: json["name"] as String,
    age: json["age"] as int,
  );

  Map<String, dynamic> get toJson => {
    "email": email,
    "name": name,
    "age": age,
  };
}
