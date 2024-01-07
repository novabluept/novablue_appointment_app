
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
        name = 'Utilizador';
        break;
      case UserRoles.worker:
        name = 'Trabalhador';
        break;
      case UserRoles.admin:
        name = 'Administrador';
        break;

    }
    return name;
  }

  String get roleEn {
    String name;
    switch (this) {
      case UserRoles.user:
        name = 'User';
        break;
      case UserRoles.worker:
        name = 'Worker';
        break;
      case UserRoles.admin:
        name = 'Admin';
        break;

    }
    return name;
  }
}

class UserRoleCompanyShopSupabase {

  final int id;
  final String userId;
  final int? companyId;
  final int? shopId;
  final String rolePt;
  final String roleEn;
  final bool active;

  UserRoleCompanyShopSupabase({
    required this.id,
    required this.userId,
    this.companyId,
    this.shopId,
    required this.rolePt,
    required this.roleEn,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': this.userId,
      'company_id': this.companyId,
      'shop_id': this.shopId,
      'role_pt': this.rolePt,
      'role_en': this.roleEn,
      'active': this.active
    };
  }

  factory UserRoleCompanyShopSupabase.fromJson(Map<String, dynamic> json) {
    return UserRoleCompanyShopSupabase(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      companyId: json['company_id'] != null ? json['company_id'] as int : null,
      shopId: json['shop_id'] != null ? json['shop_id'] as int : null,
      rolePt: json['role_pt'] as String,
      roleEn: json['role_en'] as String,
      active: json['active'] as bool,
    );
  }

  @override
  bool operator == (Object other) =>
    identical(this, other) ||
    other is UserRoleCompanyShopSupabase &&
      id == other.id &&
      userId == other.userId &&
      companyId == other.companyId &&
      shopId == other.shopId &&
      rolePt == other.rolePt &&
      roleEn == other.roleEn &&
      active == other.active;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ companyId.hashCode ^ shopId.hashCode ^ rolePt.hashCode ^ roleEn.hashCode ^ active.hashCode;

  @override
  String toString() {
    return 'UserRoleCompanySupabase{id: $id, userId: $userId, companyId: $companyId,shopId: $shopId, rolePt: $rolePt, roleEn: $roleEn, active: $active}';
  }
}