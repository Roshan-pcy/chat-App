import 'package:flutter/material.dart';

class UserUi extends StatelessWidget {
  final String username;
  final void Function()? onTap;
  const UserUi({super.key, required this.username, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [const Icon(Icons.person), Text(username)],
        ),
      ),
    );
  }
}
