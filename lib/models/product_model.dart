import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/themes_Colors.dart';

class ProductModel with ChangeNotifier {
  TextEditingController pIdController = TextEditingController();
  TextEditingController pNameController = TextEditingController();
  TextEditingController pQuantityController = TextEditingController();
  TextEditingController pPriceController = TextEditingController();
  String? _selectedCategory;

  Future<void> saveProduct(context, BuildContext ctx) async {
    String productId = pIdController.text.trim();
    String productName = pNameController.text.trim();
    String productQuantity = pQuantityController.text.trim();
    int productPrice = int.parse(pPriceController.text.trim());
    String? value = _selectedCategory;

    if (productId.isNotEmpty &&
        productName.isNotEmpty &&
        productQuantity.isNotEmpty &&
        productPrice != null &&
        value != null) {
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      if (productDoc.exists) {
        _showDuplicateCategoryDialog(ctx);
      } else {
        Map<String, dynamic> newProduct = {
          'ID': productId,
          'Name': productName,
          'Category': value,
          'Quantity': productQuantity,
          'Price': productPrice,
        };
        FirebaseFirestore.instance
            .collection('Products')
            .doc(productId)
            .set(newProduct);
        pIdController.clear();
        pNameController.clear();
        pQuantityController.clear();
        pPriceController.clear();
        value = null;

        _showNotification();
      }
    } else {
      _showFillAllFieldsDialog(ctx);
    }
  }

  void _showFillAllFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.black)),
          content: Text('Please fill all the fields',
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
          content: Text('Product already exists',
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
              child: Text('OK', style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }
}

class DecoratedDropdown extends StatefulWidget {
  final ProductModel productModel;

  DecoratedDropdown(this.productModel);

  @override
  _DecoratedDropdownState createState() => _DecoratedDropdownState();
}

class _DecoratedDropdownState extends State<DecoratedDropdown> {
  // List for category names
  List<String> categoryNames = [];
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    fetchCategoryNames();
  }

  // Fetching category names in dropdown button
  Future<void> fetchCategoryNames() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();
    List<String> names =
        querySnapshot.docs.map((doc) => doc['Category'] as String).toList();
    setState(() {
      categoryNames = names;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.secondary, width: 1),
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
          hint:
              Text('Select a Category', style: TextStyle(color: Colors.black)),
          value: _selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          iconSize: 24,
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
              widget.productModel._selectedCategory = newValue;
              print('$newValue');
            });
          },
          items: categoryNames.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.black),
                child: Text('$value'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
