import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/provider/token_provider.dart';
import 'package:vococase/provider/connectivity_status_provider.dart';
import 'package:vococase/view/home_view.dart';
import 'package:vococase/view/login_view.dart';
import 'package:vococase/view/no_internet_view.dart';

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
    var connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    final tokenAsyncValue = ref.watch(tokenProvider);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected ||
        connectivityStatusProvider == ConnectivityStatus.NotDetermined) {
      return const MaterialApp(home: NoInternetView());
    }
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: tokenAsyncValue.when(
            data: (token) {
              if (token != null) {
                return const HomeView();
              } else {
                return const LoginView();
              }
            },
            loading: () => const CircularProgressIndicator.adaptive(),
            error: (error, stackTrace) => Text('Error: $error'),
          ),
        ),
      ),
    );
  }
}
