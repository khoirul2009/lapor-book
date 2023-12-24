import 'package:flutter/material.dart';

import '../../models/akun.dart';

class AllLaporan extends StatelessWidget {
  final Akun akun;

  const AllLaporan({super.key, required this.akun});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('All Laporan Page'),
    );
  }
}
