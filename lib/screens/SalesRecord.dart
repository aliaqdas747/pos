import 'package:flutter/material.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/themes_Colors.dart';

class SalesRecordPage extends StatefulWidget {
  @override
  _SalesRecordPageState createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  Map<String, List<SaleData>> _salesRecords = {};

  void _addSale(String date, SaleData saleData) {
    if (!_salesRecords.containsKey(date)) {
      _salesRecords[date] = [];
    }
    _salesRecords[date]!.add(saleData);
  }

  List<SaleData> _getSalesByDate(String date) {
    return _salesRecords[date] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _addSale('2023-03-01', SaleData(item: 'Item 1', quantity: 2, price: 10.99));
    _addSale('2023-03-01', SaleData(item: 'Item 2', quantity: 3, price: 9.99));
    _addSale('2023-03-02', SaleData(item: 'Item 3', quantity: 1, price: 12.99));
    _addSale('2023-03-02', SaleData(item: 'Item 4', quantity: 4, price: 8.99));
    _addSale('2023-03-03', SaleData(item: 'Item 5', quantity: 2, price: 11.99));
    _addSale('2023-03-04', SaleData(item: 'Item 6', quantity: 1, price: 14.99));
    _addSale('2023-03-05', SaleData(item: 'Item 7', quantity: 3, price: 13.99));
    _addSale('2023-03-05', SaleData(item: 'Item 8', quantity: 2, price: 10.99));
    _addSale('2023-03-06', SaleData(item: 'Item 9', quantity: 1, price: 12.99));
    _addSale('2023-03-07', SaleData(item: 'Item 10', quantity: 4, price: 9.99));
    _addSale(
        '2023-03-08', SaleData(item: 'Item 11', quantity: 2, price: 11.99));
    _addSale(
        '2023-03-09', SaleData(item: 'Item 12', quantity: 1, price: 14.99));
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
                itemCount: _salesRecords.keys.length,
                itemBuilder: (context, index) {
                  String date = _salesRecords.keys.elementAt(index);
                  return Card(
                    child: ExpansionTile(
                      title: Text(
                        date,
                        style: TextStyle(fontSize: 18),
                      ),
                      children: _getSalesByDate(date).map((sale) {
                        return ListTile(
                          title: Text(sale.item),
                          subtitle: Text(
                            'Quantity: ${sale.quantity}, Price: ${sale.price}',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
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

class SaleData {
  String item;
  int quantity;
  double price;

  SaleData({required this.item, required this.quantity, required this.price});
}
