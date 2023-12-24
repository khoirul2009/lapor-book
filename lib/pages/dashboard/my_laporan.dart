import 'package:flutter/material.dart';
import 'package:lapor_book/models/akun.dart';

class MyLaporan extends StatelessWidget {
  final Akun akun;
  const MyLaporan({super.key, required this.akun});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Laporan Page'),
    );
  }
}
