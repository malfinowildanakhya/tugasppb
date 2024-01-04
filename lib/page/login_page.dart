import 'package:bacaan_sholat/page/main_page.dart';
import 'package:bacaan_sholat/page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(30),
        child: Stack(
          children: [
            ListView(
              children: [
                Image.asset(
                  'assets/images/bg_doa.png',
                  height: 250,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text, password: password.text);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                            (route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Email & password incorrect. Try again'),
                              backgroundColor: Colors.orange.shade400,
                            ));

                            email.clear();
                            password.clear();
                          });
                        } else if (e.code == 'user-not-found') {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('User not found'),
                              backgroundColor: Colors.orange.shade400,
                            ));

                            email.clear();
                            password.clear();
                          });
                        }
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text(e.toString()),
                        //   backgroundColor: Colors.orange.shade400,
                        // ));
                      }
                    },
                    child: Text('Login')),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text('Register'))
                  ],
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
