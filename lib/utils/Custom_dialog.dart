import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Custom_Dialog extends StatefulWidget {
  const Custom_Dialog({super.key});

  @override
  State<Custom_Dialog> createState() => _Custom_Dialog();
}

class _Custom_Dialog extends State<Custom_Dialog> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return AlertDialog(
            content: Center(
              child: Text("NO Item in Cart"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        }

        var CartProducts = snapshot.data!.docs;
        double totalPrice = 0;
        for (var doc in CartProducts) {
          var data = doc.data() as Map<String, dynamic>;
          totalPrice += data['Price'] ?? 0;
        }

        return AlertDialog(
          content: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                children: CartProducts.map((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  return Column(
                    children: [],
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            Text(
              'Total: ${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
