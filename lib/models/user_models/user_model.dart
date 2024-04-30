class UserModel {
  String? uid;
  String? name;
  String? email;
  String? location;
  String? photoUrl;
  String? phoneNumber;
  String? password;
  String? bio;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.location,
    this.photoUrl,
    this.phoneNumber,
    this.password,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['userUID'];
    name = json['username'];
    phoneNumber = json['contact'];
    location = json['location'];
    email = json['emailAddress'];
    photoUrl = json['profile_image'];
    password = json['password'];
    bio = json['bio'];
  }
}
