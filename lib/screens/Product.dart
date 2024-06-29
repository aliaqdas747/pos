import 'package:flutter/material.dart';

import '../utils/Summary_card.dart';
import '../utils/TextField.dart';
import '../utils/action_btn.dart';
import 'homePage.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}
var PrimaryClr = Color(0xFF6C63FF);
class _ProductScreenState extends State<ProductScreen> {
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

            SizedBox(width: 30,)
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

                      Container(height: 200,width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/product.png',height: 100,),
                            Text('Products',style: Theme.of(context).textTheme.headlineLarge,)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.dashboard, color: Colors.white),
                          title: Text('DASHBOARD', style: Theme.of(context).textTheme.headlineSmall ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProductScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.shopping_bag, color: Colors.white),
                          title: Text('PRODUCTS', style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.category, color: Colors.white),
                          title: Text('CATEGORY', style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.receipt,color: Colors.white),
                          title: Text('SALES RECORDS', style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                        },
                        child: ListTile(
                            leading: Icon(Icons.bar_chart, color: Colors.white),
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
                        margin: EdgeInsets.all(20),
                        child: Row(

                          children: [
                            Expanded(
                                child: CustomTextField(label: 'Product id', isPassword: false,  )
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(label: 'Name', isPassword: false,  )
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(label: 'Category', isPassword: false,  )
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
                       margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                       height: 50,width:double.infinity,
                     child: SizedBox(
                       width: 100,
                       child:   TextField(style: TextStyle(color: Colors.white),

                         decoration: InputDecoration(

                           suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search,color: PrimaryClr),),
                           label: Text("Search here...", style: TextStyle(color: PrimaryClr,),),
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
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        ),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 300,
                        width: double.infinity,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Product ID')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('CATEGORY')),
                            DataColumn(label: Text('Price')),
                          ],
                          rows: [
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
                              cells: [
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
                                "Save Product",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                            // Save for Later Button
                            ElevatedButton(
                              onPressed: () {
                                // Handle Save for Later action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "UPDATE",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),


                            // Discard Sale Button
                            ElevatedButton(

                              onPressed: () {
                                // Handle Discard Sale action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "DELETE ITEM",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            color: PrimaryClr,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                        margin: EdgeInsets.only(left: 20,right: 20),
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [

                            SumryCard(title: 'Total Items', amount: '12'),
                            SumryCard(title: 'Total Category:', amount: '100'),
                            SumryCard(title: 'Total Product Amount', amount: '1200'),



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
