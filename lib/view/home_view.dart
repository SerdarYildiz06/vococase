import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/provider/user_list_provider.dart';
import 'package:vococase/service/local_storage_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Voco Test Case'),
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
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(users[index].avatar),
                      ),
                      title: Text(users[index].firstName),
                      subtitle: Text(users[index].lastName),
                    );
                  },
                );
              },
              loading: () => const CircularProgressIndicator.adaptive(),
              error: (error, stackTrace) => Text('Error: $error'),
            );
          },
        ),
      ),
    );
  }
}
