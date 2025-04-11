import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_api_exampl/post_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp())); // Correct
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Get Api')),
      body: postList.when(
        data:
            (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title), // Correct
                    subtitle: Text(item.body),
                  ),
                );
              },
            ),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error: $error')), // Correct
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
