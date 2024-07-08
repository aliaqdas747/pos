import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/utils/TextField.dart';
import 'package:point_of_sale/utils/drawer.dart';
import '../utils/Summary_card.dart';
import '../utils/action_btn.dart';

class point_of_sale extends StatefulWidget {
  const point_of_sale({super.key});

  @override
  State<point_of_sale> createState() => _point_of_saleState();
}

class _point_of_saleState extends State<point_of_sale> {
  var PrimaryClr = const Color(0xFF6C63FF);
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black54,
        elevation: 10.0,
        centerTitle: true,
        title: Text("POINT OF SALE", style: Theme.of(context).textTheme.headlineLarge),
    actions: [
    StreamBuilder(
    stream: Stream.periodic(Duration(seconds: 45)),
    builder: (context, snapshot) {
    return Text(
    "Time  ${DateTime.now().hour}:${DateTime.now().minute} ",
    style: Theme.of(context).textTheme.headlineMedium,
    );
    },
    ),
    const SizedBox(width: 30),
    ],
    backgroundColor: PrimaryClr,
    ),
    body: Row(
    children: [
    DrawerWidget(title: 'POS', imagePath: 'assets/images/pos.png',),
    Flexible(
    flex: 4,
    child: SizedBox(
    child: SingleChildScrollView(
    child: Column(
    children: [
    Container(

    margin: const EdgeInsets.all(20),

    child: Column(
      children: [
        const Row(
        children: [
        Expanded(
        child: CustomTextField(label: 'Product id', isPassword: false, ),
        ),
        SizedBox(width: 10),
        Expanded(
        child: CustomTextField(label: 'Name', isPassword: false, ),
        ),
        SizedBox(width: 10),
        Expanded(
        child: CustomTextField(label: 'QUANTITY', isPassword: false, ),
        ),
        SizedBox(width: 10),
        Expanded(
        child: CustomTextField(label: 'Price', isPassword: false, ),
        ),
        ],
        ),
        Container(

          margin: EdgeInsets.only(left: 25,right: 25,bottom: 10,top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Select Date and Time: ',style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked!= null && picked!= _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Text('Select Date'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (picked!= null && picked!= _selectedTime) {
                    setState(() {
                      _selectedTime = picked;
                    });
                  }
                },
                child: Text('Select Time'),
              ),
              SizedBox(width: 10),
              Text('Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              SizedBox(width: 10),
              Text('Selected Time: ${_selectedTime.hour}:${_selectedTime.minute}'),
            ],
          ),
        ),
      ],
    ),

    width: double.infinity,
    decoration: BoxDecoration(
    color: PrimaryClr,
    borderRadius: BorderRadius.circular(10),
    ),
    ),

    Container(
    decoration: BoxDecoration(
    color: PrimaryClr,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    margin: const EdgeInsets.only(left: 20, right: 20),
    height: 300,
    width: double.infinity,
    child: DataTable(
    columns: const [
    DataColumn(label: Text('Product ID')),
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('QUANTITY')),
    DataColumn(label: Text('Price')),
    ],
    rows: const [
    DataRow(
    cells: [
    DataCell(Text('1')),
    DataCell(Text('Apple iPhone')),
    DataCell(Text('2')),
    DataCell(Text('1200')),
    ],
    ),
    DataRow(
    cells: [
    DataCell(Text('2')),
    DataCell(Text('Samsung TV')),
    DataCell(Text('1')),
    DataCell(Text('800')),
    ],
    ),
    DataRow(
    cells: const [
    DataCell(Text('3')),
    DataCell(Text('Nike Shoes')),
    DataCell(Text('3')),
    DataCell(Text('500')),
    ],
    ),
    ],
    ),
    ),
    ActionButtonsRow(),

      Container(
        decoration: BoxDecoration(
          color: PrimaryClr,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: const Wrap(
          alignment: WrapAlignment.center,
          children: [
            SumryCard(title: 'Total Items', amount: '12'),
            SumryCard(title: 'Subtotal RS:', amount: '100'),
            SumryCard(title: 'Total Amount', amount: '1200'),
            SumryCard(title: 'Amount Paid:', amount: '1200'),
            SumryCard(title: 'Change to return:', amount: '0'),
          ],
        ),
      ),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    );
  }
}