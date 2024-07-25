import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/boxes/cart_Database.dart';
import 'package:point_of_sale/models/cart_item.dart';

// SaleModel class to manage cart operations
class SaleModel with ChangeNotifier {
  final currentTime = DateTime.now();
  late final String formattedTime =
      '${currentTime.hour}:${currentTime.minute}:${currentTime.second}';

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController priceController = TextEditingController();

  final CartDatabase _cartDatabase = CartDatabase();

  SaleModel() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _cartDatabase.openBox();
  }

  Future<void> saveToCart(BuildContext context) async {
    String id = idController.text.trim();
    String name = nameController.text.trim();
    String quantity = quantityController.text.trim();
    String price = priceController.text.trim();

    if (id.isEmpty ||
        name.isEmpty ||
        quantity.isEmpty ||
        price.isEmpty ||
        !id.isNum ||
        !quantity.isNum ||
        !price.isNum) {
      _showFillAllFieldsDialog(context);
    } else {
      final cartItem = CartItem(
          id: id,
          name: name,
          quantity: int.parse(quantity),
          price: double.parse(price));

      _cartDatabase.addItem(cartItem);
      idController.clear();
      nameController.clear();
      quantityController.text = '1';
      priceController.clear();
      print(cartItem);
    }
  }

  void _showFillAllFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: const Text(
              "Please ensure all fields are completed and verify that the ID is a numeric value.",
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

class DropdownSearchbar extends StatefulWidget {
  final TextEditingController nameController;
  const DropdownSearchbar({super.key, required this.nameController});

  @override
  State<DropdownSearchbar> createState() => _DropdownSearchbarState();
}

class _DropdownSearchbarState extends State<DropdownSearchbar> {
  late final SaleModel salemodel;
  final TextEditingController _productController = TextEditingController();
  final List<String> _allProducts = [];
  String _selectedProduct = '';

  @override
  void initState() {
    super.initState();
    fetchProductName();
  }

  //function to fetch
  Future<void> fetchProductName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    List<String> productName =
        querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
    setState(() {
      _allProducts.addAll(productName);
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownField(
          controller: _productController,
          hintText: 'Search Product',
          enabled: true,
          items: _allProducts,
          onValueChanged: (value) {
            setState(() {
              _selectedProduct = value;
              widget.nameController.text = value; // Update nameController
            });
          },
        ),
      ],
    );
  }
}
