import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
      required this.title,
  required this.icon,
  required this.onPressed,
  this.endIcon = true,
  this.textColor,
}) : super (key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // ignore: deprecated_member_use
          color: Colors.brown.withOpacity(0.1),
        ),
        child:  Icon(icon, color: Colors.black),
      ),
      title:  Text(title),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // ignore: deprecated_member_use
          color: Colors.brown.withOpacity(0.1),
        ),
        child: const Icon(LineAwesomeIcons.angle_right_solid, size: 18, color: Colors.grey),
      ): null,
    );
  }
}
