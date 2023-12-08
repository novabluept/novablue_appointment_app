
enum userRoles{
  user,
  worker,
  admin,
}

class UserRoleCompanySupabase {

  final int id;
  final int userId;
  final int companyId;
  final String role;

  UserRoleCompanySupabase({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'user_id': this.userId,
      'company_id': this.companyId,
      'role': this.role,
    };
  }

  factory UserRoleCompanySupabase.fromJson(Map<String, dynamic> json) {
    return UserRoleCompanySupabase(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      companyId: json['company_id'] as int,
      role: json['role'] as String,
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is UserRoleCompanySupabase &&
      id == other.id &&
      userId == other.userId &&
      companyId == other.companyId &&
      role == other.role;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ companyId.hashCode ^ role.hashCode;
}