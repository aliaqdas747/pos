import 'package:flutter/material.dart';

class DecoratedDropdown extends StatefulWidget {
  @override
  _DecoratedDropdownState createState() => _DecoratedDropdownState();
}

class _DecoratedDropdownState extends State<DecoratedDropdown> {
  String? _selectedValue;
  final List<String> _dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.lime, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select a Category', style: TextStyle(color: Colors.black)),
          value: _selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          iconSize: 24,
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(color: Colors.deepPurpleAccent),),
            );
          }).toList(),
        ),
      ),
    );
  }
}
