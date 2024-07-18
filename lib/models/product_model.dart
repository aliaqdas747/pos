import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class product_model with ChangeNotifier{
  TextEditingController p_id_Controller = TextEditingController();
  TextEditingController P_name_Controller =TextEditingController();
  TextEditingController P_Quantity  =TextEditingController();
  TextEditingController P_Price =TextEditingController();



  Future<void> SaveProduct(context, BuildContext) async {
   String Product_id = p_id_Controller.text.trim();
   String Product_Name = P_name_Controller.text.trim();
   String Product_quantity = P_Quantity.text.trim();
   String Product_Price = P_Price.text.trim();

   if(Product_id.isNotEmpty  && Product_Name.isNotEmpty && Product_quantity.isNotEmpty && Product_Price.isNotEmpty){

     DocumentSnapshot productDoc = await FirebaseFirestore.instance.collection('Products').doc(Product_id).get();
    if(productDoc.exists){
      _showDuplicateCategoryDialog(context);
    }else{
      Map<String,dynamic> newProduct ={
        'ID':Product_id,
        'Name':Product_Name,
        'Quantity':Product_quantity,
        'Price':Product_Price,
      };
      FirebaseFirestore.instance.collection('Products').doc(Product_id).set(newProduct);
      p_id_Controller.clear();
      P_name_Controller.clear();
      P_Quantity.clear();
      P_Price.clear();

      _showNotification();
    }


   }else{
     _showFillAllFieldsDialog(context);

   }




  }
  void _showFillAllFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.black)),
          content: Text('Please fill all the fields', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF), // Use your primary color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }
  void _showNotification() {
    Get.snackbar(
      'Notification',
      'Category has been successfully saved',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }
  void _showDuplicateCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.black)),
          content: Text('Product already exists', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF), // Use your primary color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }
}