import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/controller/user_controller.dart';
import 'package:vococase/model/user_model.dart';

// final userControllerProvider =
//     Provider<UserController>((ref) => UserController());
// final usersProvider = FutureProvider<List<User>>((ref) async {
//   final controller = ref.read(userControllerProvider);
//   return controller.fetchUsers();
// });
final userControllerProvider =
    Provider<UserController>((ref) => UserController());
final usersProvider = FutureProvider<List<User>>((ref) async {
  final controller = ref.read(userControllerProvider);
  return controller.fetchUsers();
});
