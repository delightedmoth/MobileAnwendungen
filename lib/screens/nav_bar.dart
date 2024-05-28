import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/NavBarCat.png"),
                  fit: BoxFit.cover),
            ),
            child: Text('Settings'),
          ),
          ListTile(
            title: Text('Fill Database'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Dump Database'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
