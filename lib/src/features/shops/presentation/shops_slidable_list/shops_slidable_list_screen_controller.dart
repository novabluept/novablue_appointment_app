
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/shops/data/shops_repository.dart';

class ShopsSlidableListScreenController extends StateNotifier<AsyncValue<void>>{

  final ShopsRepository shopsRepository;

  ShopsSlidableListScreenController({required this.shopsRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> getShops() async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => shopsRepository.getShops());
    if(mounted){
      state = newState;
    }
  }

}

final shopsSlidableListScreenControllerProvider = StateNotifierProvider.autoDispose<ShopsSlidableListScreenController,AsyncValue<void>>((ref) {
  final shopsRepository = ref.watch(shopsRepositoryProvider);
  return ShopsSlidableListScreenController(shopsRepository: shopsRepository);
});