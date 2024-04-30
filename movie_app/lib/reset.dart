import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/auth.dart';
import 'package:movie_app/widgets/widget_tree.dart';


class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPage();
}

class _ResetPage extends State<ResetPage> {
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }
  Widget _title() {
    return const Text(
      'Enter your email for reset password',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    );
  }

  String? errorMessage = '';

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _controllerEmail.text.trim());

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Check your inbox mail"),
            content: Text("Press OK to log in again"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WidgetTree()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseException catch (e) {
      errorMessage = e.message;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  final TextEditingController _controllerEmail = TextEditingController();

  Widget textFiled() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _controllerEmail,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Email",
                filled: true),
          )),
      ElevatedButton(
        onPressed: () => resetPassword(context),
        child: Text(
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white54),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Column(
          children: [
            _title(),
            textFiled(),
          ],
        ));
  }
}
