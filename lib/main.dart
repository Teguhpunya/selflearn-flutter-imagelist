import 'package:flutter/material.dart';
import 'package:image_unsplash/layout/main_layout.dart';
import 'package:image_unsplash/ui/photo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Image Browser';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Browser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainLayout(title: title, body: BrowsePhotos()),
    );
  }
}
