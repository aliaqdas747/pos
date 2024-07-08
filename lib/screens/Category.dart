import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/Summary_card.dart';
import '../utils/TextField.dart';
import '../utils/drawer.dart';


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
            DrawerWidget(title: 'CATEGORIES', imagePath: 'assets/images/category.png',),
            Flexible(
              flex: 4,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.all(20),
                        child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                            Expanded(
                              flex: 2,
                                child: CustomTextField(label: 'Category Name', isPassword: false,  )
                            ),
                            Expanded(
                                flex: 3,
                                child: CustomTextField(label: 'Discription', isPassword: false,  )
                            ),
                            ElevatedButton(
                              onPressed: () {

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:const Text(
                                "Save New Category",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                      const SizedBox(width: 20,),
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
                              label: Text("Search here", style: TextStyle(color: primaryClr,fontSize: 25),),
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
                        decoration: BoxDecoration(
                            color: primaryClr,
                            borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        ),
                        margin:const EdgeInsets.only(left: 20,right: 20,top: 5),
                        width: double.infinity,
                        child:const Wrap(
                          alignment: WrapAlignment.end,
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
