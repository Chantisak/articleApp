import 'package:flutter/material.dart';
import 'package:shop/src/constants/constant.dart';
import 'package:shop/src/views/login.dart';

import '../services/net_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
 bool _passwordVisible = false;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(color: Constant.BACK_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Constant.WHITE_COLOR,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(16),
                    isDense: false,
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  TextField(
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
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  NetService()
                      .register(
                    nameController.text.trim(),
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                  )
                      .then((value) async {   
                    if (value.result == 'ok') {
                      Navigator.pop(context);
                      const snackBar = SnackBar(
                        content: Text('สมัครสำเร็จ'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text(value.message ?? ''),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                child: Text('Register'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
