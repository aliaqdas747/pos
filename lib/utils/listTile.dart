import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  CustomListTile({
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      trailing: Icon(

        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 18.0,
      ),
      onTap: onPressed,
    );
  }
}
