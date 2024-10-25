import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        _isSelected = !_isSelected;
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[700],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: _isSelected
              ? Row(
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                )
              : Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
