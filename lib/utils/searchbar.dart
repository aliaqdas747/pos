import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: 50,
      width: double.infinity,
      child: SizedBox(
        width: 100,
        child: TextField(
          style: const TextStyle(color: AppColors.primary),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: AppColors.primary),
            ),
            label: const Text(
              "Search here...",
              style: TextStyle(color: AppColors.primary, fontSize: 25),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
