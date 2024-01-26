import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/provider/user_list_provider.dart';
import 'package:vococase/service/local_storage_service.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Voco Test Case'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final localStorageService = LocalStorageService();
              await localStorageService.clear();
            },
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final usersAsyncValue = ref.watch(usersProvider);

            return usersAsyncValue.when(
              data: (users) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index].firstName),
                      subtitle: Text(users[index].lastName),
                    );
                  },
                );
              },
              loading: () => CircularProgressIndicator.adaptive(),
              error: (error, stackTrace) => Text('Error: $error'),
            );
          },
        ),
      ),
    );
  }
}
