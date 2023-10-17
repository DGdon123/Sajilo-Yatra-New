import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginscreenPasswordObscureProvider = StateProvider<bool>((ref) {
  return true;
});

final loginSignUPloadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final forgotpasswordloadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final resetpasswordloadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final signUpcreenPasswordObscureProvider = StateProvider<bool>((ref) {
  return false;
});

final isUserProvider = StateProvider<bool>((ref) {
  return true;
});

final loginloadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final changePasswordLoading = StateProvider.autoDispose<bool>((ref) {
  return false;
});
