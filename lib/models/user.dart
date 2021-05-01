class User {
  User({this.id, this.email});
  int id;
  String email;

  static User fromJson(Map<String, dynamic> data) {
    return User(id: data['id'], email: data['title']);
  }
}
