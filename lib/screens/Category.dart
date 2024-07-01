import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/Summary_card.dart';
import '../utils/TextField.dart';
import 'Product.dart';
import 'homePage.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  final Color primaryClr = const Color(0xFF6C63FF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black54,
          elevation: 10.0,
          centerTitle: true,
          title: Text("POINT OF SALE", style: Theme.of(context).textTheme.headlineLarge),
          actions:const [
            SizedBox(width: 30,)
          ],
          backgroundColor: primaryClr,
        ),
        body:     Row(
          children: [
            Flexible(
              child: Container(
                width: 300, // Set the width of the drawer
                color: primaryClr, // Optional background color for the drawer
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 200,width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/category.png',height: 100,),
                            Text('Category',style: Theme.of(context).textTheme.headlineLarge,)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
                        },
                        child: ListTile(
                          leading:const Icon(Icons.dashboard, color: Colors.white),
                          title: Text('DASHBOARD', style: Theme.of(context).textTheme.headlineSmall ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ProductScreen()));
                        },
                        child: ListTile(
                          leading:const Icon(Icons.shopping_bag, color: Colors.white),
                          title: Text('PRODUCTS', style: Theme.of(context).textTheme.headlineSmall),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoryScreen()));
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
                        margin:const EdgeInsets.all(20),
                        child: Row(

                          children:const [
                            Expanded(
                                child: CustomTextField(label: 'Category Id', isPassword: false,  )
                            ),
                            SizedBox(width: 10),

                            Expanded(
                                child: CustomTextField(label: 'Category Name', isPassword: false,  )
                            ),
                          ],
                        ),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryClr,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                        height: 50,width:double.infinity,
                        child: SizedBox(
                          width: 100,
                          child:   TextField(style: TextStyle(color: primaryClr),

                            decoration: InputDecoration(

                              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search,color: primaryClr),),
                              label: Text("Search here...", style: TextStyle(color: primaryClr,fontSize: 25),),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryClr, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryClr, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: primaryClr,
                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                        ),
                        margin:const EdgeInsets.only(left: 20, right: 20),
                        height: 300,
                        width: double.infinity,
                        child: DataTable(
                          columns:const [
                            DataColumn(label: Text('CATEGORY ID')),

                            DataColumn(label: Text('CATEGORY NAME')),

                          ],
                          rows:const [
                            DataRow(
                              cells:  [

                                DataCell(Text('2')),
 
                                DataCell(Text('1200')),
                              ],
                            ),
                            DataRow(
                              cells: [

                                DataCell(Text('1')),
                                DataCell(Text('800')),
                              ],
                            ),
                            DataRow(
                              cells: [

                                DataCell(Text('3')),
                                DataCell(Text('500')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        padding:const EdgeInsets.symmetric(vertical: 10),
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
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:const Text(
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
                                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:const Text(
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
                                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:const Text(
                                "DELETE ITEM",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            color: primaryClr,
                            borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                        margin:const EdgeInsets.only(left: 20,right: 20),
                        width: double.infinity,
                        child:const Wrap(
                          alignment: WrapAlignment.center,
                          children: [

                              Expanded(
                                  flex: 10,
                                  child: SumryCard(title: 'Total Categories:', amount: '100')),
                     


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
