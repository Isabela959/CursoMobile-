import 'package:flutter/material.dart';
import 'views/image_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geo Camera MVC',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeView(),
    );
  }
}
