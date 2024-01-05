
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
  final bool active;

  UserRoleCompanySupabase({
    required this.id,
    required this.userId,
    this.companyId,
    required this.rolePt,
    required this.roleEn,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': this.userId,
      'company_id': this.companyId,
      'role_pt': this.rolePt,
      'role_en': this.roleEn,
      'active': this.active
    };
  }

  factory UserRoleCompanySupabase.fromJson(Map<String, dynamic> json) {
    return UserRoleCompanySupabase(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      companyId: json['company_id'] != null ? json['company_id'] as int : null,
      rolePt: json['role_pt'] as String,
      roleEn: json['role_en'] as String,
      active: json['active'] as bool,
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
      roleEn == other.roleEn &&
      active == other.active;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ companyId.hashCode ^ rolePt.hashCode ^ roleEn.hashCode ^ active.hashCode;

  @override
  String toString() {
    return 'UserRoleCompanySupabase{id: $id, userId: $userId, companyId: $companyId, rolePt: $rolePt, roleEn: $roleEn, active: $active}';
  }
}