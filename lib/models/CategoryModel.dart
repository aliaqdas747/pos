import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryModel with ChangeNotifier {
  TextEditingController categoryCntr = TextEditingController();
  TextEditingController discContr = TextEditingController();

  void saveCategory(BuildContext context) async {
    String categoryName = categoryCntr.text.trim();
    String detail = discContr.text.trim();

    if (categoryName.isNotEmpty && detail.isNotEmpty) {
      // Check if category already exists
      DocumentSnapshot categoryDoc = await FirebaseFirestore.instance
          .collection('Categories')
          .doc(categoryName)
          .get();

      if (categoryDoc.exists) {
        _showDuplicateCategoryDialog(context);
      } else {
        Map<String, dynamic> newCategory = {
          'Category': categoryName,
          'details': detail,
        };

        FirebaseFirestore.instance
            .collection('Categories')
            .doc(categoryName)
            .set(newCategory);
        categoryCntr.clear();
        discContr.clear();
        _showNotification();
      }
    } else {
      _showFillAllFieldsDialog(context);
    }
  }

  void _showNotification() {
    Get.snackbar(
      'Notification',
      'Category has been successfully saved',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  void _showFillAllFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: const Text('Please fill all the fields',
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF6C63FF), // Use your primary color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }

  void _showDuplicateCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: const Text('Category already exists',
              style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF6C63FF), // Use your primary color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }
}
