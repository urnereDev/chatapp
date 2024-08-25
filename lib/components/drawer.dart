import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceTint,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Icon(Icons.person,size: 80, color: Theme.of(context).colorScheme.primary,)),
              Padding(padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: const Text("H O M E"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),),
              Padding(padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage(),));
                  },
                ),),

            ],
          ),
          Padding(padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),),
        ],
      ),
    );
  }
}
