import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/themes_Colors.dart';

class SalesRecordPage extends StatefulWidget {
  @override
  _SalesRecordPageState createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _salesRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchSalesRecords();
  }

  Future<void> _fetchSalesRecords() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('/sales_records/2024-08-03/Records')
          .get();
      setState(() {
        _salesRecords = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching sales records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Sales Records',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _salesRecords.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> saleData = _salesRecords[index];
                  return Card(
                    child: ListTile(
                      title: Text(saleData['item']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${saleData['quantity']}'),
                          Text('Price: ${saleData['price']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
