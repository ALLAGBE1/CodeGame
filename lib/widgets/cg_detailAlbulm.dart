import 'package:flutter/material.dart';

class CGDetailAlbulm extends StatelessWidget {
  const CGDetailAlbulm({super.key, required this.labelText});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(),
      title: Text(labelText),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
      ),
    );
  }
}
