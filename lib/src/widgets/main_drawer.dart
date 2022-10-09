import 'package:flutter/material.dart';
import 'package:shop/src/app.dart';
import 'package:shop/src/services/local_storage_service.dart';
import 'package:shop/src/views/home.dart';
import 'package:shop/src/views/login.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('HOME'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  }),
              const Divider(),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'LOGOUT',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  LocalStorageService().removeToken();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buttons() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: const [Icon(Icons.local_mall), Text('HOME')],
      ),
    );
  }
}
