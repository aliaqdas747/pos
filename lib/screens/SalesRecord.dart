import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/themes_Colors.dart';

class SaleRecordsPage extends StatefulWidget {
  @override
  _SalesRecordPageState createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SaleRecordsPage> {
  Future<void> _deleteProduct(String docId) async {
    await FirebaseFirestore.instance
        .collection('sales_records')
        .doc(docId)
        .delete();
  }

  List<Map<String, dynamic>> _salesRecords = [];

  @override
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
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
            const Text(
              'Sales Records',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 350,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sales_records')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var products = snapshot.data!.docs;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Product Id")),
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Price")),
                        DataColumn(label: Text("Date/Time")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: products.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        String docId = doc.id;

                        // Format the timestamp
                        String formattedTimestamp = '';
                        if (data['timestamp'] != null &&
                            data['timestamp'] is Timestamp) {
                          Timestamp timestamp = data['timestamp'];
                          DateTime dateTime = timestamp.toDate();
                          formattedTimestamp =
                              DateFormat('MM/dd/yyyy, HH:mm:ss')
                                  .format(dateTime);
                        }

                        return DataRow(cells: [
                          DataCell(Text(data['Id'].toString() ?? '')),
                          DataCell(Text(data['item'].toString() ?? '')),

                          // Assuming 'category' field exists
                          DataCell(Text(data['price'].toString() ?? '')),
                          DataCell(Text(
                              formattedTimestamp)), // Use the formatted timestamp
                          DataCell(Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _deleteProduct(docId);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
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
