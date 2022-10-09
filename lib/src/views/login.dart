import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/src/constants/constant.dart';
import 'package:shop/src/services/local_storage_service.dart';
import 'package:shop/src/services/net_service.dart';
import 'package:shop/src/views/home.dart';
import 'package:shop/src/views/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            _buildCardLogin(),
            const SizedBox(height: 20),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                child: Text('Register'),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCardLogin() => Card(
        color: Constant.WHITE_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Constant.WHITE_COLOR,
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(16),
                  isDense: false,
                  hintText: 'Username',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              controller: usernameController,
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              obscureText: !_passwordVisible, //ซ่อนรหัสผ่าน
              decoration: InputDecoration(
                filled: true,
                fillColor: Constant.WHITE_COLOR,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(16),
                isDense: false,
                hintText: 'password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                   color: Colors.blue,
                  ),
                ),
              ),
              controller: passwordController,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  NetService()
                      .login(
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  )
                      .then((value) async {
                    if (value.status == 'Ok') {
                      // Obtain shared preferences.

                      LocalStorageService()
                          .setUserInfo(value.name ?? '', value.token ?? '');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                          (Route<dynamic> route) => false);
                    } else {
                      const snackBar = SnackBar(
                        content: Text('รหัสผ่านไม่ถูกต้อง'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                child: Text('LOGIN'),
              ),
            )
          ],
        ),
      );
}
