import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  static const _appBarContentPadding = EdgeInsets.symmetric(horizontal: 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: _appBarContentPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.menu),
                Text('NewYork Times'),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
