import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:point_of_sale/screens/pos.dart';
import 'package:point_of_sale/utils/Summary_card.dart';
import 'package:point_of_sale/utils/cards.dart';
import 'package:point_of_sale/utils/todo_card.dart';

import 'Category.dart';
import 'Product.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var PrimaryClr = Color(0xFF6C63FF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black54,
        elevation: 10.0,
        centerTitle: true,
        title: Text("Dashboard", style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 45)),
            builder: (context, snapshot) {
              return Text(
                "Time  ${DateTime.now().hour}:${DateTime.now().minute} ",
                style:Theme.of(context).textTheme.headlineMedium
              );
            },
          ),
          SizedBox(width: 30,)
        ],
        backgroundColor: PrimaryClr,
      ),
      body: Row(
        children: [
          Flexible(

            child: Container(
              width: 300, // Set the width of the drawer
              color: Colors.grey[200], // Optional background color for the drawer
              child: Column(

                children: [

                  UserAccountsDrawerHeader(
                    accountName: Text("POS",style: Theme.of(context).textTheme.headlineMedium),
                    accountEmail: Text("POINT OF SALE"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'), // Your profile image
                    ),
                    decoration: BoxDecoration(
                      color:PrimaryClr
                    ),
                  ),
                  Flexible(child: Todo_Card()),


                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text('POWERED BY AL-BASTIE',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.deepPurpleAccent),),
                   )

                  // Add more ListTiles for other drawer items
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Wrap(
                      alignment: WrapAlignment.center,
                      children: [

                        home_cards(title: 'POINT OF SALE', cardImg: 'assets/images/pos.png', OnPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>point_of_sale()));
                        },),
                        home_cards(title: 'PRODUCTS', cardImg: 'assets/images/product.png', OnPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen()));
                        },),
                        home_cards(title: 'CATEGORY', cardImg: 'assets/images/category.png', OnPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                        },),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        home_cards(title: 'SALES RECORDS', cardImg: 'assets/images/sales.png', OnPressed: () {  },),
                        home_cards(title: 'Lab', cardImg: 'assets/images/mobile.png', OnPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>point_of_sale()));
                        },),
                        home_cards(title: 'USERS', cardImg: 'assets/images/man.png', OnPressed: () {  },),
                      ],
                    ),
                    Container( width: double.infinity,color: PrimaryClr,
                    child: SingleChildScrollView(

                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 160,),
                        SumryCard(title: 'Total Sale', amount: '12000'),
                          SumryCard(title: 'Product Count', amount: '12000'),
                          SumryCard(title: 'Categories Count', amount: '12000'),


                        ],
                      ),
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
