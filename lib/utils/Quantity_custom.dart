import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

class CategoryQuantity extends StatefulWidget {
  const CategoryQuantity({super.key});

  @override
  State<CategoryQuantity> createState() => _CategoryQuantityState();
}

class _CategoryQuantityState extends State<CategoryQuantity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          int categoryCount = snapshot.data!.docs.length;
          return Row(
            children: [
              const Text(
                'Total Categories:  ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Schyler'),
              ),
              Text(
                '$categoryCount',
                style: const TextStyle(fontSize: 20, color: Colors.green),
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
      color: Colors.white,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          int categoryCount = snapshot.data!.docs.length;
          return Row(
            children: [
              const Text(
                'Stock Products:  ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Schyler'),
              ),
              Text(
                '$categoryCount',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ],
          );
        },
      ),
    );
    // Save for Later Button
  }
}

class CartItemCount extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Cart').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Text(
              'Total item count: ${snapshot.data?.docs.length}',
              style: const TextStyle(fontSize: 24),
            ),
          );
        } else {
          return Container(
            child: const Text('Loading...'),
          );
        }
      },
    );
  }
}

///////Sub total Amount
class SubTotal extends StatefulWidget {
  const SubTotal({super.key});

  @override
  State<SubTotal> createState() => _SubTotalState();
}

class _SubTotalState extends State<SubTotal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // Calculate subtotal
            double subtotal = 0.0;
            for (var doc in snapshot.data!.docs) {
              subtotal += (doc['Price'] ?? 0).toDouble();
            }
            // Calculate subtotal

            return Row(
              children: [
                const Text(
                  'Subtotal:  ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Schyler',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '₨ $subtotal',
                  style:
                      const TextStyle(fontSize: 20, color: AppColors.primary),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/////
class ItemCount extends StatefulWidget {
  const ItemCount({super.key});

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              'No Items',
              style: TextStyle(color: Colors.black),
            ));
          }
          int itemCount = snapshot.data!.docs.length;
          return Row(
            children: [
              const Text(
                'Total items:  ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'Schyler'),
              ),
              Text(
                '$itemCount',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ],
          );
        },
      ),
    );
  }
}
