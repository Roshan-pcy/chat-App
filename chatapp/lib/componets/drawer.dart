import 'package:chatapp/pages/SettingPage.dart';
import 'package:flutter/material.dart';

class DrawerUi extends StatelessWidget {
  const DrawerUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.music_note,
            size: 40,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: ListTile(
              title: Text(
                'H O M E',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10),
            child: ListTile(
              title: const Text('S E T T I N  G'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
