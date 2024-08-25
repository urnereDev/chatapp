import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.person),
            Text(text)
          ],
        ),
      ),
    );
  }
}
