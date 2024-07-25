import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryQuantity extends StatefulWidget {
  const CategoryQuantity({super.key});

  @override
  State<CategoryQuantity> createState() => _CategoryQuantityState();
}

class _CategoryQuantityState extends State<CategoryQuantity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          int categoryCount = snapshot.data!.docs.length;
          return Row(
            children: [
              Text(
                'Total Categories:  ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Schyler'),
              ),
              Text(
                '$categoryCount',
                style: TextStyle(
                    fontFamily: 'Schyler', fontSize: 20, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Product_Quantity extends StatefulWidget {
  const Product_Quantity({super.key});

  @override
  State<Product_Quantity> createState() => _Product_QuantityState();
}

class _Product_QuantityState extends State<Product_Quantity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          int categoryCount = snapshot.data!.docs.length;
          return Row(
            children: [
              Text(
                'Total Products:  ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Schyler'),
              ),
              Text(
                '$categoryCount',
                style: TextStyle(
                    fontFamily: 'Schyler', fontSize: 20, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
    // Save for Later Button
  }
}
