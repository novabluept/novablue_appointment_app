
class UserSupabase {

  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String phoneCode;
  /// Additional fields
  String? userImageUrl;

  UserSupabase({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.phoneCode,
    this.userImageUrl = null,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'phone': phone,
      'phone_code': phoneCode,
    };
  }

  factory UserSupabase.fromJson(Map<String, dynamic> json) {
    return UserSupabase(
      id: json['id'] as String,
      firstname: json['first_name'] as String,
      lastname: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      phoneCode: json['phone_code'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is UserSupabase &&
        id == other.id &&
        firstname == other.firstname &&
        lastname == other.lastname &&
        email == other.email &&
        phone == other.phone &&
        phoneCode == other.phoneCode;

  @override
  int get hashCode =>
    id.hashCode ^
    firstname.hashCode ^
    lastname.hashCode ^
    email.hashCode ^
    phone.hashCode ^
    phoneCode.hashCode;

  @override
  String toString() {
    return 'UserSupabase{id: $id, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, phoneCode: $phoneCode}';
  }
}
