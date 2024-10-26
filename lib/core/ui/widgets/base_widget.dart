import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({
    super.key,
    required this.child,
    required this.searchController,
  });

  final TextEditingController searchController;
  final Widget Function(bool isSearching) child;

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button
          },
        ),
        title: _isSearching
            ? TextField(
                controller: widget.searchController,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                autofocus: true,
              )
            : const Center(child: Text("NewYork Times")),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  widget.searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: widget.child(_isSearching),
    );
  }
}
