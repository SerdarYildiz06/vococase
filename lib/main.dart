import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/provider/token_provider.dart';
import 'package:vococase/service/local_storage_service.dart';
import 'package:vococase/view/home_view.dart';
import 'package:vococase/view/login_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenAsyncValue = ref.watch(tokenProvider);
    return MaterialApp(
      home: tokenAsyncValue.when(
        data: (token) {
          if (token != null) {
            return HomeView();
          } else {
            return const LoginView();
          }
        },
        loading: () => const CircularProgressIndicator.adaptive(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
