import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Make sure to configure Firebase in your Flutter project.

class DatesOfRecordsDropdown extends StatefulWidget {
  @override
  _DatesOfRecordsDropdownState createState() => _DatesOfRecordsDropdownState();
}

class _DatesOfRecordsDropdownState extends State<DatesOfRecordsDropdown> {
  String? selectedDate; // Holds the selected date
  List<String> dates = []; // List to store dates fetched from Firestore

  @override
  void initState() {
    super.initState();
    fetchDatesFromFirestore();
  }

  // Fetch dates from the Firestore collection
  void fetchDatesFromFirestore() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sales_records').get();
      List<String> fetchedDates = snapshot.docs.map((doc) => doc.id).toList();
      setState(() {
        dates = fetchedDates; // Update the state with fetched dates
      });
    } catch (e) {
      print('Error fetching dates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('Select Date'),
          value: selectedDate,
          onChanged: (String? newValue) {
            setState(() {
              selectedDate = newValue; // Update the selected date
            });
          },
          items: dates.map<DropdownMenuItem<String>>((String date) {
            return DropdownMenuItem<String>(
              value: date,
              child: Text(date),
            );
          }).toList(),
        ),
      ),
    );
  }
}
