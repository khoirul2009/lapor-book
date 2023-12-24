import 'package:flutter/material.dart';

import '../../models/akun.dart';

class Profile extends StatelessWidget {
  final Akun akun;
  const Profile({super.key, required this.akun});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile'),
    );
  }
}
