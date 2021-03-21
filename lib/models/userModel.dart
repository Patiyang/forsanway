class Users {
  final String id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String title;
  final String identityType;
  final String identityNumber;
  final String mobile;
  final String userImage;

  Users({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.title,
    this.identityType,
    this.identityNumber,
    this.mobile,
    this.userImage,
  });

  factory Users.fromJson(Map<String, dynamic> json) => new Users(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        title: json['title'],
        identityType: json['identity_type'],
        identityNumber: json['identity_number'],
        mobile: json['mobile'],
        userImage: json['user_image']
      );

}
