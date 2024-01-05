
enum ShopStatus{
  public,
  private
}

class ShopSupabase {

  final int id;
  final int companyId;
  final String name;
  final String status;
  final String country;
  final String state;
  final String streetName;
  final String streetNumber;
  final String postalCode;

  const ShopSupabase({
    required this.id,
    required this.companyId,
    required this.name,
    required this.status,
    required this.country,
    required this.state,
    required this.streetName,
    required this.streetNumber,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'company_id': this.companyId,
      'name': this.name,
      'status': this.status,
      'country': this.country,
      'state': this.state,
      'street_name': this.streetName,
      'street_number': this.streetNumber,
      'postal_code': this.postalCode,
    };
  }

  factory ShopSupabase.fromJson(Map<String, dynamic> map) {
    return ShopSupabase(
      id: map['id'] as int,
      companyId: map['company_id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      country: map['country'] as String,
      state: map['state'] as String,
      streetName: map['street_name'] as String,
      streetNumber: map['street_number'] as String,
      postalCode: map['postal_code'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is ShopSupabase &&
      id == other.id &&
      companyId == other.companyId &&
      name == other.name &&
      status == other.status &&
      country == other.country &&
      state == other.state &&
      streetName == other.streetName &&
      streetNumber == other.streetNumber &&
      postalCode == other.postalCode;

  @override
  int get hashCode =>
    id.hashCode ^
    companyId.hashCode ^
    name.hashCode ^
    status.hashCode ^
    country.hashCode ^
    state.hashCode ^
    streetName.hashCode ^
    streetNumber.hashCode ^
    postalCode.hashCode;

  @override
  String toString() {
    return 'ShopSupabase{id: $id, companyId: $companyId, name: $name, status: $status, country: $country, state: $state, streetName: $streetName, streetNumber: $streetNumber, postalCode: $postalCode}';
  }
}
