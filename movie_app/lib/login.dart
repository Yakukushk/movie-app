import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/reset.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }
  Future<void> resetPassword() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: "${user?.email}");
  }
Widget _title() {
    return const Text("Firebase Auth");
}
Widget _userId() {
    return Text( user?.email ?? 'User mail');
}
Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
}
  Widget _resetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final route = MaterialPageRoute(
          builder: (context) => ResetPage(),
        );
        Navigator.push(context, route);
      },
      child: const Text('Reset password'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _userId(),
            _signOutButton(),
            _resetButton(context),
          ],
        ),
      ),
    );
  }
}
