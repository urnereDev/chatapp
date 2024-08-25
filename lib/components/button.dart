import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const Button({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(7)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(text,),
      ),
    );
  }
}
