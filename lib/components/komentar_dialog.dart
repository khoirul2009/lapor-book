import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/components/input_widget.dart';
import 'package:lapor_book/models/akun.dart';
import 'package:lapor_book/models/laporan.dart';

class KomentarDialog extends StatefulWidget {
  final Laporan laporan;
  final Akun akun;

  const KomentarDialog({super.key, required this.laporan, required this.akun});

  @override
  State<KomentarDialog> createState() => _KomentarDialogState();
}

class _KomentarDialogState extends State<KomentarDialog> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String komentar = "";

  void addKomentar() async {
    CollectionReference transaksiCollection = _firestore.collection('laporan');
    try {
      await transaksiCollection.doc(widget.laporan.docId).update({
        'komentar': FieldValue.arrayUnion([
          {'nama': widget.akun.nama, 'isi': komentar}
        ])
      });

      Navigator.popAndPushNamed(context, '/dashboard');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orangeAccent,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.laporan.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            InputWidget(
                label: '',
                inputField: TextFormField(
                  onChanged: (String value) => setState(() {
                    komentar = value;
                  }),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  decoration: customInputDecoration(''),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addKomentar();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Posting Komentar'),
            ),
          ],
        ),
      ),
    );
  }
}
