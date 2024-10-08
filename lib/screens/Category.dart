import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:point_of_sale/themes_Colors.dart';
import 'package:point_of_sale/utils/Summary_card.dart';
import '../utils/TextField.dart';
import '../utils/drawer.dart';
import '../models/CategoryModel.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryModel _categoryModel = CategoryModel();

  Future<void> _deleteCategory(String docId) async {
    await FirebaseFirestore.instance
        .collection('Categories')
        .doc(docId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black54,
        elevation: 10.0,
        centerTitle: true,
        title: Text("POINT OF SALE",
            style: Theme.of(context).textTheme.headlineLarge),
        actions: const [SizedBox(width: 30)],
        backgroundColor: AppColors.primary,
      ),
      body: Row(
        children: [
          const DrawerWidget(
              title: 'CATEGORIES', imagePath: 'assets/images/category.png'),
          Flexible(
            flex: 4,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              label: 'Category Name',
                              isPassword: false,
                              controller: _categoryModel.categoryCntr,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              label: 'Description',
                              isPassword: false,
                              controller: _categoryModel.discContr,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                _categoryModel.saveCategory(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Save New Category",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        style: const TextStyle(
                          color: AppColors.primary,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: AppColors.primary,
                            ),
                          ),
                          label: const Text("Search here",
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 25)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    //DataTable
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 300,
                      width: double.infinity,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Categories')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          var categories = snapshot.data!.docs;
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('CATEGORY NAME')),
                                DataColumn(label: Text('DESCRIPTION')),
                                DataColumn(label: Text('ACTIONS')),
                              ],
                              rows: categories.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                String docId = doc.id;

                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(data['Category'] ?? ''),
                                    ),
                                    DataCell(
                                      Text(data['details'] ?? ''),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.limeAccent,
                                            ),
                                            onPressed: () async {
                                              await _deleteCategory(docId);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),

                    //Total Category Item
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Products')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                int categoryCount = snapshot.data!.docs.length;
                                return Row(
                                  children: [
                                    const Text(
                                      'Total Products:  ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Schyler'),
                                    ),
                                    Text(
                                      '$categoryCount',
                                      style: const TextStyle(
                                          fontFamily: 'Schyler',
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          // Save for Later Button
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Categories')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: const CircularProgressIndicator());
                                }
                                int categoryCount = snapshot.data!.docs.length;
                                return Row(
                                  children: [
                                    const Text(
                                      'Total Categories:  ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Schyler'),
                                    ),
                                    Text(
                                      '$categoryCount',
                                      style: const TextStyle(
                                          fontFamily: 'Schyler',
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          // Discard Sale Button
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
