import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

class home_cards extends StatefulWidget {
  final String title;
  final String cardImg;
  final VoidCallback OnPressed;

  const home_cards({
    super.key,
    required this.title,
    required this.cardImg,
    required this.OnPressed,
  });

  @override
  _HomeCardsState createState() => _HomeCardsState();
}

class _HomeCardsState extends State<home_cards> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.OnPressed,
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 2.5,
                color: _isHovering
                    ? AppColors.secondary
                    : Colors.black54, // Change color based on hover state
              ),
            ],
          ),
          height: 200,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.cardImg, height: 100),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }
}
