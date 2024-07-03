import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/action_btn.dart';
import '../utils/drawer.dart';

 class SaleRecord extends StatefulWidget {
   const SaleRecord({super.key});

   @override
   State<SaleRecord> createState() => _SaleRecordState();
 }
final Color PrimaryClr =const Color(0xFF6C63FF);

 class _SaleRecordState extends State<SaleRecord> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         shadowColor: Colors.black54,
         elevation: 10.0,
         centerTitle: true,
         title: Text("Sales Records", style: Theme.of(context).textTheme.headlineLarge),
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
       body: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           DrawerWidget(title: 'SALES RECORD', imagePath: 'assets/images/sales.png',),
           Flexible(
             flex: 3,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   margin:const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                   height: 50,width:double.infinity,
                   child: SizedBox(
                     width: 100,
                     child:   TextField(style: TextStyle(color: PrimaryClr),

                       decoration: InputDecoration(

                         suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search,color: PrimaryClr),),
                         label: Text("Search here...", style: TextStyle(color: PrimaryClr,fontSize: 25),),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: PrimaryClr, width: 1.0),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: PrimaryClr, width: 1.0),
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                     ),
                   ),
                 ),
                 Container(
                   decoration: BoxDecoration(
                       color: PrimaryClr,
                       borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                   ),
                   margin:const EdgeInsets.only(left: 20, right: 20),
                   height: 500,
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
                       DataRow(
                         cells:const [
                           DataCell(Text('3')),
                           DataCell(Text('Nike Shoes')),
                           DataCell(Text('3')),
                           DataCell(Text('500')),
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
                       DataRow(
                         cells:const [
                           DataCell(Text('3')),
                           DataCell(Text('Nike Shoes')),
                           DataCell(Text('3')),
                           DataCell(Text('500')),
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
       Container(
         width: double.infinity,
         margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
         padding: EdgeInsets.symmetric(vertical: 10),
         decoration: BoxDecoration(
           color: Colors.grey[300],
           borderRadius: BorderRadius.circular(10),
         ),
         child: Wrap(
           alignment: WrapAlignment.spaceEvenly,
           children: [
             ElevatedButton(

               onPressed: () {
                 // Handle Discard Sale action
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.teal,
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),
               child: Text(
                 "Clear Data",
                 style: TextStyle(color: Colors.white, fontSize: 16),
               ),
             ),
             // Save for Later Button

           ],
         ),
       ),
               ],
             ),
           ),


         ],
       ),
     );
   }
 }
