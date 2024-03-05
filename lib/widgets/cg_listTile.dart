import 'package:flutter/material.dart';

class CGListTile extends StatelessWidget {
  const CGListTile({super.key, required this.labelText});
  final String labelText;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(labelText),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
      ),
    );
  }
}



