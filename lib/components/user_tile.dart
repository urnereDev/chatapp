import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(Icons.person),
            SizedBox(width: 30,),
            Text(text)
          ],
        ),
      ),
    );
  }
}
