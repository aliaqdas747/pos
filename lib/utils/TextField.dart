import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final Function(String)? onChanged;
  final bool isPassword;
  final TextEditingController? controller;
  final int? maxlines;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.isPassword,
    this.controller,
    this.maxlines,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: widget.onChanged,
        maxLength: widget.maxlines,
        controller: widget.controller,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
