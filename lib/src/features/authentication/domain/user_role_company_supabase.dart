
enum userRoles{
  user,
  worker,
  admin,
}


class UserRoleCompanySupabase {

  final int userId;
  final int companyId;
  final String role;

  UserRoleCompanySupabase({
    required this.userId,
    required this.companyId,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': this.userId,
      'company_id': this.companyId,
      'role': this.role,
    };
  }

  factory UserRoleCompanySupabase.fromJson(Map<String, dynamic> json) {
    return UserRoleCompanySupabase(
      userId: json['user_id'] as int,
      companyId: json['company_id'] as int,
      role: json['role'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is UserRoleCompanySupabase &&
      userId == other.userId &&
      companyId == other.companyId &&
      role == other.role;

  @override
  int get hashCode => userId.hashCode ^ companyId.hashCode ^ role.hashCode;

  @override
  String toString() {
    return 'UserRoleCompanySupabase{userId: $userId, companyId: $companyId, role: $role}';
  }

}