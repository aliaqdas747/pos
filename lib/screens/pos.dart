import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/utils/TextField.dart';
import 'package:point_of_sale/utils/textTheme.dart';

import '../utils/Summary_card.dart';
import '../utils/action_btn.dart';
import '../utils/todo_card.dart';
import 'homePage.dart';

class point_of_sale extends StatefulWidget {
  const point_of_sale({super.key});

  @override
  State<point_of_sale> createState() => _point_of_saleState();
}

class _point_of_saleState extends State<point_of_sale> {
  var PrimaryClr = const Color(0xFF6C63FF);
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
            stream:  Stream.periodic(Duration(seconds: 45)),
            builder: (context, snapshot) {
              return Text(
                  "Time  ${DateTime.now().hour}:${DateTime.now().minute} ",
                  style:Theme.of(context).textTheme.headlineMedium
              );
            },
          ),
          const  SizedBox(width: 30,)
        ],
        backgroundColor: PrimaryClr,
      ),
      body:     Row(

        children: [
          Flexible(

            child: Container(
              width: 300, // Set the width of the drawer
              color: PrimaryClr, // Optional background color for the drawer
              child: SingleChildScrollView(
                child: Column(

                  children: [

                    SizedBox(height: 200,width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/pos.png',height: 100,),
                        Text('POS',style: Theme.of(context).textTheme.headlineLarge,)
                      ],
                    ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
                      },
                      child: ListTile(
                        leading: const Icon(Icons.dashboard, color: Colors.white),
                        title: Text('DASHBOARD', style: Theme.of(context).textTheme.headlineSmall ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                      },
                      child: ListTile(
                        leading:const Icon(Icons.shopping_bag, color: Colors.white),
                        title: Text('PRODUCTS', style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                      },
                      child: ListTile(
                        leading:const Icon(Icons.category, color: Colors.white),
                        title: Text('CATEGORY', style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                      },
                      child: ListTile(
                        leading:const Icon(Icons.receipt,color: Colors.white),
                        title: Text('SALES RECORDS', style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                      },
                      child: ListTile(
                        leading:const Icon(Icons.bar_chart, color: Colors.white),
                        title: Text('REPORTS', style: Theme.of(context).textTheme.headlineSmall)),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text('POWERED BY AL-BASTIE',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.deepPurpleAccent),),
                    )

                    // Add more ListTiles for other drawer items
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child:  const Row(

                        children:  [
                          Expanded(
                              child:   CustomTextField(label: 'Product id', isPassword: false,  )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(label: 'Name', isPassword: false,  )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(label: 'QUANTITY', isPassword: false,  )
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(label: 'Price', isPassword: false,  )
                          ),
                        ],
                      ),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: PrimaryClr,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: PrimaryClr,
                        borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                      ),
                      margin:const EdgeInsets.only(left: 20, right: 20),
                      height: 300,
                      width: double.infinity,
                      child:   DataTable(
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
                            cells:const [
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
                        borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                      ),
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      width: double.infinity,
                      child: const Wrap(
                     alignment: WrapAlignment.center,
                        children:  [

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
      )
    );

  }
}
