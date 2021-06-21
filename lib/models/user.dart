class User {
  String? fullName;
  String? photoUrl;
  String? email;
  String? provider;
  String? uid;

  User();

  User.fromValues(
      {required this.fullName,
      required this.email,
      this.photoUrl,
      required this.provider,
      required this.uid});
}
