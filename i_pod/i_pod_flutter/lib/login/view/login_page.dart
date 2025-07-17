import 'package:flutter/material.dart';
import 'package:i_pod_flutter/home/view/home_page.dart';
import 'package:i_pod_flutter/main.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SignInWithEmailButton(
          caller: client.modules.auth,
          onSignedIn: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const MyHomePage(title: 'Serverpod Example'),
              ),
            );
          },
        ),
      ),
    );
  }
}
