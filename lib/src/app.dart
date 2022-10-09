import 'package:flutter/material.dart';
import 'package:shop/src/configs/theme/theme.dart';
import 'package:shop/src/services/local_storage_service.dart';
import 'package:shop/src/views/home.dart';
import 'package:shop/src/views/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(context),
      home: _buildPage(),
    );
  }

  FutureBuilder<String> _buildPage() => FutureBuilder<String>(
      future: LocalStorageService().getToken(),
      builder: (context, snapshot) {
        final token = snapshot.data;
       
        if (token == null || token.isEmpty) {
          return Login();
        }
        return MyHomePage();
      });
}
