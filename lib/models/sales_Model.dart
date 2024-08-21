import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Id box should have number')));
      return;
    }

    final priceParsed = int.tryParse(price);
    if (priceParsed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Price box should have number')));
      return;
    }

    try {
      DocumentSnapshot currentStock =
          await FirebaseFirestore.instance.collection('Products').doc(id).get();
      if (currentStock.exists) {
        try {
          final totalPrice = priceParsed * quantityParsed!;
          final cartRecord = {
            'Id': idParsed,
            'Name': name,
            'Quantity': quantityParsed,
            'Price': totalPrice,
          };
          await FirebaseFirestore.instance
              .collection('Cart')
              .doc()
              .set(cartRecord);
          idController.clear();
          nameController.clear();
          quantityController.text = '1';
          priceController.clear();
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error:$e')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This product not in stock records')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error:$e')));
    }
  }

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

// Function to move data from cart to SalesRecords page
  Future<void> finalizeSale(BuildContext context) async {
    try {
      // To get all cart items
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();

      if (cartSnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cart is Empty, No items to finalize")),
        );
        return;
      }

      // Reference to sales_records collection
      CollectionReference salesCollection =
          FirebaseFirestore.instance.collection('sales_records');

      // Prepare Batch write
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Use a FutureBuilder to ensure product data is fetched before updating
      List<Future<void>> futures = [];

      for (QueryDocumentSnapshot cartDoc in cartSnapshot.docs) {
        // Extract specific fields from the cart document
        Map<String, dynamic> cartData = cartDoc.data() as Map<String, dynamic>;

        Map<String, dynamic> saleRecordData = {
          'Id': cartData['Id'],
          'item': cartData['Name'],
          'quantity': cartData['Quantity'],
          'price': cartData['Price'],
          'timestamp': FieldValue.serverTimestamp()
        };

        // Create a new document in the sales_records collection with auto-generated ID
        DocumentReference saleRecordRef =
            salesCollection.doc(); // Auto-generated ID
        batch.set(saleRecordRef, saleRecordData);

        // Update the product quantity in the Products Collection
        DocumentReference productRef = FirebaseFirestore.instance
            .collection('Products')
            .doc(cartData['Id'].toString());

        // Add a future to fetch product data and update quantity
        futures.add(productRef.get().then((productSnapshot) {
          if (productSnapshot.exists) {
            Map<String, dynamic> productData =
                productSnapshot.data() as Map<String, dynamic>;
            int currentQuantity = productData['Quantity'] ?? 0;
            int cartQuantity = cartData['Quantity'] ?? 0;

            // Calculate the new Quantity
            int newQuantity = currentQuantity - cartQuantity;
            if (newQuantity < 0)
              newQuantity = 0; // Ensure quantity doesn't go negative
            batch.update(productRef, {'Quantity': newQuantity});
          }
        }));

        // Delete the document from cart collection
        batch.delete(cartDoc.reference);
      }

      // Wait for all futures to complete before committing batch
      await Future.wait(futures);
      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill is Saved in Sales Records')));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

//Function to show data in list
  Future<List<Map<String, dynamic>>> fetchSaleRecords(String date) async {
    List<Map<String, dynamic>> saleRecordsList = [];

    try {
      // Reference to the daily Sale document
      CollectionReference dailySalesCollection = FirebaseFirestore.instance
          .collection('Sale Records')
          .doc(date)
          .collection('Records');

      // Fetching the records
      QuerySnapshot querySnapshot = await dailySalesCollection.get();

      // Check if there are any records
      if (querySnapshot.docs.isEmpty) {
        print("No sale records found for the date: $date");
        return saleRecordsList; // Return an empty list
      }

      // Iterate through the documents and extract data
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> recordData = doc.data() as Map<String, dynamic>;
        saleRecordsList.add(recordData); // Add the record to the list
      }

      return saleRecordsList; // Return the populated list
    } catch (e) {
      print("Error fetching sale records: $e");
      return []; // Return an empty list in case of error
    }
  }

//Function to fetch name

  Future<List<String>> getAllSaleDates() async {
    List<String> saleDates = [];

    try {
      // Get the collection reference for 'Sale Records'
      CollectionReference saleRecordsCollection =
          FirebaseFirestore.instance.collection('Sale Records');

      // Get all documents from the 'Sale Records' collection
      QuerySnapshot snapshot = await saleRecordsCollection.get();

      // Iterate over the documents and add the document IDs (dates) to the list
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        saleDates.add(doc.id); // The document ID is the date string
      }

      // Print the list of dates
      print(saleDates);
    } catch (e) {
      print('Error fetching sale dates: $e');
    }

    return saleDates;
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
