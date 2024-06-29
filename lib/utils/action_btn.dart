import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
      alignment: WrapAlignment.spaceEvenly,
        children: [
          ElevatedButton(

            onPressed: () {
              // Handle Discard Sale action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Add Item",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Save for Later Button
          ElevatedButton(
            onPressed: () {
              // Handle Save for Later action
            },
            style: ElevatedButton.styleFrom(
           backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Save for Later",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Finalize Sale Button
          ElevatedButton(
            onPressed: () {
              // Handle Finalize Sale action
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Finalize Sale",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Discard Sale Button
          ElevatedButton(

            onPressed: () {
              // Handle Discard Sale action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Discard Sale",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
