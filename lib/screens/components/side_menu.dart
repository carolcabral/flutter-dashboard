import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
                title: "Dashboard",
                svgSource: "assets/icons/menu_dashbord.svg",
                press: () {}),
            DrawerListTile(
                title: "Notification",
                svgSource: "assets/icons/menu_notification.svg",
                press: () {}),
            DrawerListTile(
                title: "Profile",
                svgSource: "assets/icons/menu_profile.svg",
                press: () {}),
            DrawerListTile(
                title: "Settings",
                svgSource: "assets/icons/menu_setting.svg",
                press: () {}),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, svgSource;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSource,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSource,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
