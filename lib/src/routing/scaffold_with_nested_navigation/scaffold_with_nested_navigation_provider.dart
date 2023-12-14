
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref){
  return 0;
});

final isBottomLoadingProvider = StateProvider<bool>((ref){
  return false;
});