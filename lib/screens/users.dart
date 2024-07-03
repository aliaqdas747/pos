import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/screens/Category.dart';
import 'package:point_of_sale/utils/drawer.dart';
import '../utils/Summary_card.dart';
import '../utils/TextField.dart';
import 'homePage.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Color primaryClr = const Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black54,
        elevation: 10.0,
        centerTitle: true,
        title: Text("User Management", style: Theme.of(context).textTheme.headlineLarge),
        actions: const [
          SizedBox(width: 30,)
        ],
        backgroundColor: primaryClr,
      ),
      body: Row(
        children: [
          DrawerWidget(title: 'Users', imagePath: 'assets/images/man.png',),
          Flexible(
            flex: 4,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: const Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                                label: 'Username', isPassword: false,)
                          ),
                          Expanded(
                              child: CustomTextField(
                                label: 'Email', isPassword: false,)
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: CustomTextField(
                                label: 'Role', isPassword: false,)
                          ),
                          Expanded(
                              child: CustomTextField(
                                label: 'Password', isPassword: true,)
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
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      height: 50, width: double.infinity,
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          style: TextStyle(color: primaryClr),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search, color: primaryClr),
                            ),
                            label: Text("Search here...", style: TextStyle(color: primaryClr, fontSize: 25)),
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
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 300,
                      width: double.infinity,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Username')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Role')),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Text('JohnDoe')),
                              DataCell(Text('john@example.com')),
                              DataCell(Text('Admin')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('JaneDoe')),
                              DataCell(Text('jane@example.com')),
                              DataCell(Text('User')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('MikeSmith')),
                              DataCell(Text('mike@example.com')),
                              DataCell(Text('Moderator')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Save User action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Save User",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          // Update Button
                          ElevatedButton(
                            onPressed: () {
                              // Handle Update User action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Update User",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          // Delete User Button
                          ElevatedButton(
                            onPressed: () {
                              // Handle Delete User action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Delete User",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: primaryClr,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: double.infinity,
                      child: const Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SumryCard(title: 'Total Users', amount: '150'),
                          SumryCard(title: 'Admins:', amount: '10'),
                          SumryCard(title: 'Users:', amount: '120'),
                          SumryCard(title: 'Moderators:', amount: '20'),
                        ],
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
