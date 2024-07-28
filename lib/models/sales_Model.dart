import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SaleModel with ChangeNotifier {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController priceController = TextEditingController();

//Function to fetch Name by id
  Future<void> fetchNamebyId(BuildContext context, String id) async {
    try {
      var doc =
          await FirebaseFirestore.instance.collection('Products').doc(id).get();
      if (doc.exists) {
        nameController.text = doc.data()?['Name'] ?? '';
        priceController.text = doc.data()?['Price'] ?? '';
        notifyListeners();
      } else {}
    } catch (e) {
      print('This error indicate that: $e');
    }
  }

//Function to fetch Id by Name
  Future<void> FetchIdbyName(BuildContext context, Name) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Product')
          .where('Name', isEqualTo: Name)
          .get();
      if (querySnapshot.docs.isEmpty) {
        var doc = querySnapshot.docs.first;
        priceController.text = doc.data()['Price']?.toString() ?? '';
      }
    } catch (e) {
      print('Error Indicate that :$e');
    }
  }

//Function to add product to cart

  Future<void> AddCart(BuildContext context) async {
    String id = idController.text.trim();
    String name = nameController.text.trim();
    String quantity = quantityController.text.trim();
    String price = priceController.text.trim();

    if (id.isEmpty ||
        name.isEmpty ||
        quantity.isEmpty ||
        price.isEmpty ||
        !id.isNum) {
      _showFillAllFieldsDialog(context);
    } else {
      Map<String, dynamic> saleRecord = {
        'Id': id,
        'Name': name,
        'Quantity': quantity,
        'Price': price
      };
      FirebaseFirestore.instance.collection('Cart').doc().set(saleRecord);

      idController.clear();
      nameController.clear();
      quantityController.text = '1';
      priceController.clear();
    }
  }

  void _showFillAllFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: const Text(
              'Please fill all the fields or \nCheck the ID is a number',
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
  final SaleModel saleModel;
  const DropdownSearchbar(
      {super.key, required this.nameController, required this.saleModel});

  @override
  State<DropdownSearchbar> createState() => _DropdownSearchbarState();
}

class _DropdownSearchbarState extends State<DropdownSearchbar> {
  final TextEditingController _productController = TextEditingController();
  final List<String> _allProducts = [];
  String _selectedProduct = '';

  @override
  void initState() {
    super.initState();
    fetchProductName();
    widget.saleModel.idController.addListener(() {
      if (widget.saleModel.idController.text.isNotEmpty) {
        widget.saleModel
            .fetchNamebyId(context, widget.saleModel.idController.text)
            .then((_) {
          setState(() {
            _selectedProduct = widget.saleModel.nameController.text;
            _productController.text = _selectedProduct;
          });
        });
      } else {
        setState(() {
          _selectedProduct = '';
          _productController.clear();
        });
      }
    });
  }

  // Function to fetch product names
  Future<void> fetchProductName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    List<String> productName =
        querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
    setState(() {
      _allProducts.addAll(productName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final saleModel = Provider.of<SaleModel>(context);
    return Column(
      children: [
        DropDownField(
          controller: _productController,
          hintText: 'Search Product',
          enabled: true,
          items: _allProducts,
          onValueChanged: (value) async {
            setState(() {
              _selectedProduct = value;
              widget.nameController.text = value; // Update nameController
            });

            // Fetch ID and price when name is selected
            await FirebaseFirestore.instance
                .collection('Products')
                .where('Name', isEqualTo: value)
                .get()
                .then((querySnapshot) {
              if (querySnapshot.docs.isNotEmpty) {
                var doc = querySnapshot.docs.first;
                saleModel.idController.text =
                    doc.data()['ID']?.toString() ?? '';
                saleModel.priceController.text =
                    doc.data()['Price']?.toString() ?? '';
              }
            });
          },
        ),
      ],
    );
  }
}/*class _DropdownSearchbarState extends State<DropdownSearchbar> {
  final TextEditingController _productController = TextEditingController();
  final List<String> _allProducts = [];
  String _selectedProduct = '';

  @override
  void initState() {
    super.initState();
    fetchProductName();
  }

  // Function to fetch product names
  Future<void> fetchProductName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    List<String> productName =
        querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
    setState(() {
      _allProducts.addAll(productName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final saleModel = Provider.of<SaleModel>(context);
    return Column(
      children: [
        DropDownField(
          onValueChanged: (value) async {
            setState(() {
              _selectedProduct = value;
              widget.nameController.text = value; // Update nameController
            });

            // Fetch ID and price when name is selected
            await FirebaseFirestore.instance
                .collection('Products')
                .where('Name', isEqualTo: value)
                .get()
                .then((querySnapshot) {
              if (querySnapshot.docs.isNotEmpty) {
                var doc = querySnapshot.docs.first;
                saleModel.idController.text =
                    doc.data()['ID']?.toString() ?? '';
                saleModel.priceController.text =
                    doc.data()['Price']?.toString() ?? '';
              }
            });
          },
          controller: _productController,
          hintText: 'Search Product',
          enabled: true,
          items: _allProducts,
        ),
      ],
    );
  }
} */