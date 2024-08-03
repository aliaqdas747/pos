import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SaleModel with ChangeNotifier {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController priceController = TextEditingController();

//Function to add product to cart
  Future<void> AddCart(BuildContext context) async {
    final id = idController.text.trim();
    final name = nameController.text.trim();
    final quantity = quantityController.text.trim();
    final price = priceController.text.trim();

    final idParsed = int.tryParse(id);
    final quantityParsed = int.tryParse(quantity);

    if (idParsed == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Id should be  Numeric')));
      return;
    }
    final priceParsed = int.tryParse(price);
    if (priceParsed == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Price should be Numeric')));
      return;
    }
    try {
      final cartRecord = {
        'Id': idParsed,
        'Name': name,
        'Quantity': quantityParsed,
        'Price': priceParsed,
      };
      await FirebaseFirestore.instance.collection('Cart').doc().set(cartRecord);
      idController.clear();
      nameController.clear();
      quantityController.text = '1';
      priceController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error:$e')));
    }
  }
//Function to move cart items to SaleRecords collection

//Function to fetch Name by id
  Future<void> fetchNamebyId(
    BuildContext context,
    String id,
  ) async {
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

  //Function to move data to from cart to SaleRecords page
  Future<void> finalizeSale(BuildContext context) async {
    try {
//To get all cart items
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();

      if (cartSnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cart is Empty, No items to finalize")),
        );
        return;
      }
      //Get current date as YYYY-MM-DD
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      //Reference to daily  Sale document
      CollectionReference dailySalesCollection = FirebaseFirestore.instance
          .collection('sales_records')
          .doc(currentDate)
          .collection('Records');

      //Prepare Batch write
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (QueryDocumentSnapshot cartDoc in cartSnapshot.docs) {
        //Extract specific fields from the cart document
        Map<String, dynamic> cartData = cartDoc.data() as Map<String, dynamic>;

        Map<String, dynamic> saleRecordsData = {
          'item': cartData['Name'],
          'quantity': cartData['Quantity'],
          'price': cartData['Price'],
          'timestamp': FieldValue.serverTimestamp()
        };
        //Create a new document in the Records subcollection
        DocumentReference saleRecordRef = dailySalesCollection.doc();
        batch.set(saleRecordRef, saleRecordsData);

        //Delete the document form cart collection
        batch.delete(cartDoc.reference);
      }
      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bill is Saved in Sales Records')));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error:$e')));
    }
  }

//Function to fetch Id by Name
  Future<void> FetchIdbyName(BuildContext context, String Name) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Product')
          .where('Name', isEqualTo: Name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var price = doc.data()['Price'] ?? 0;
        var quantity = int.parse(
            quantityController.text); // assuming you have a quantityController
        var totalPrice = price * quantity;
        priceController.text = totalPrice.toString();
      } else {
        print('No documents found');
      }
    } catch (e) {
      print('Error Indicate that :$e');
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
                  backgroundColor: const Color.fromARGB(
                      255, 62, 180, 111) // Use your primary color
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
}
