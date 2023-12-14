
enum UserRoles{
  user,
  worker,
  admin,
}

extension SupportedLocalExtension on UserRoles{
  String get rolePt {
    String name;
    switch (this) {
      case UserRoles.user:
        name = 'utilizador';
        break;
      case UserRoles.worker:
        name = 'trabalhador';
        break;
      case UserRoles.admin:
        name = 'administrador';
        break;

    }
    return name;
  }

  String get roleEn {
    String name;
    switch (this) {
      case UserRoles.user:
        name = 'user';
        break;
      case UserRoles.worker:
        name = 'worker';
        break;
      case UserRoles.admin:
        name = 'admin';
        break;

    }
    return name;
  }
}

class UserRoleCompanySupabase {

  final int id;
  final String userId;
  final int? companyId;
  final String rolePt;
  final String roleEn;


  UserRoleCompanySupabase({
    required this.id,
    required this.userId,
    this.companyId,
    required this.rolePt,
    required this.roleEn,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': this.userId,
      'company_id': this.companyId,
      'role_pt': this.rolePt,
      'role_en': this.roleEn,
    };
  }

  factory UserRoleCompanySupabase.fromJson(Map<String, dynamic> json) {
    return UserRoleCompanySupabase(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      companyId: json['company_id'] != null ? json['company_id'] as int : null,
      rolePt: json['role_pt'] as String,
      roleEn: json['role_en'] as String,

    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is UserRoleCompanySupabase &&
      id == other.id &&
      userId == other.userId &&
      companyId == other.companyId &&
      rolePt == other.rolePt &&
      roleEn == other.roleEn;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ companyId.hashCode ^ rolePt.hashCode ^ roleEn.hashCode;
}