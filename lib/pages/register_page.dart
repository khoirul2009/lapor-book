import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/input_widget.dart';
import 'package:lapor_book/components/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  String? nama;
  String? email;
  String? noHp;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
              width: double.infinity,
            ),
            const Text(
              'Register',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Create your profile to start your journey',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputWidget(
                      inputField: TextFormField(
                        decoration: customInputDecoration('Nama lengkap'),
                        onChanged: (value) {
                          setState(() {
                            nama = value;
                          });
                        },
                        validator: notEmptyValidator,
                      ),
                      label: 'Nama',
                    ),
                    InputWidget(
                      inputField: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: notEmptyValidator,
                        decoration: customInputDecoration('email@example.com'),
                      ),
                      label: 'Email',
                    ),
                    InputWidget(
                      inputField: TextFormField(
                        decoration: customInputDecoration('+62 8512 3456 789'),
                        onChanged: (value) {
                          setState(() {
                            noHp = value;
                          });
                        },
                        validator: notEmptyValidator,
                      ),
                      label: 'No. Handphone',
                    ),
                    InputWidget(
                      inputField: TextFormField(
                        obscureText: true,
                        decoration: customInputDecoration('Password anda'),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: notEmptyValidator,
                      ),
                      label: 'Password',
                    ),
                    InputWidget(
                      inputField: TextFormField(
                        obscureText: true,
                        decoration:
                            customInputDecoration('Konfirmasi Password'),
                        onChanged: (value) {
                          setState(() {
                            confirmPassword = value;
                          });
                        },
                        validator: (value) =>
                            passwordConfirmationValidator(value, _password),
                      ),
                      label: 'Konfirmasi Password',
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              register();
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orangeAccent)),
                          child: const Text('Register'),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Anda sudah memiliki akun?'),
                        TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                ModalRoute.withName('/login')),
                            child: const Text('Login', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      CollectionReference akunCollection = _db.collection('akun');

      await _auth.createUserWithEmailAndPassword(
          email: email!, password: _password.text);

      final docId = akunCollection.doc().id;
      await akunCollection.doc(docId).set({
        'uid': _auth.currentUser!.uid,
        'nama': nama,
        'email': email,
        'noHP': noHp,
        'docId': docId,
        'role': 'user',
      });

      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
