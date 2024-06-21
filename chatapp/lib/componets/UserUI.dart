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
        margin: const EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red[100], borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              username,
              style: const TextStyle(
                  color: Color.fromARGB(255, 102, 171, 23),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
