
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/exceptions/app_exceptions.dart';
import 'package:novablue_appointment_app/src/features/company/data/companies_repository.dart';
import 'package:novablue_appointment_app/src/features/shops/domain/shop_supabase.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ShopsRepository {
  Future<List<ShopSupabase>> getShops();
}

class SupabaseShopsRepository implements ShopsRepository{

  static String shopTable() => 'shop';
  static String shopBucket() => 'shops';
  static String selectShopBucketFilePath(int id) => '${id.toString()}/shopImage';

  final Ref ref;
  final SupabaseClient _client;

  SupabaseShopsRepository(this.ref,this._client);

  String _getShopImage(int shopId) {
    try{
      return _client.storage.from(shopBucket()).getPublicUrl(selectShopBucketFilePath(shopId));
    } catch (error) {
      throw UnexpectedErrorException(ref);
    }
  }

  String _getCompanyImage(int companyId) {
    try{
      return _client.storage.from(SupabaseCompaniesRepository.companyBucket()).getPublicUrl(SupabaseCompaniesRepository.selectCompanyBucketFilePath(companyId));
    } catch (error) {
      throw UnexpectedErrorException(ref);
    }
  }

  @override
  Future<List<ShopSupabase>> getShops() async{
    try {
      final limit = 5;
      final response = await _client
        .from(shopTable())
        .select()
        .limit(limit);

      List<ShopSupabase> list = response.map((item) => ShopSupabase.fromJson(item)).toList();

      for(var shop in list){
        shop.shopImageUrl = _getShopImage(shop.id);
        shop.companyImageUrl = _getCompanyImage(shop.companyId);
      }

      return list;
    } catch (error) {
      throw UnexpectedErrorException(ref);
    }
  }
}

final shopsRepositoryProvider = Provider<SupabaseShopsRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseShopsRepository(ref,client);
});

final getShopsProvider = FutureProvider.autoDispose((ref) {
  final shopsRepository = ref.watch(shopsRepositoryProvider);
  return shopsRepository.getShops();
});