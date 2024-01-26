import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/service/local_storage_service.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  final localStorageService = LocalStorageService();
  return localStorageService.get(key: 'token');
});
