// lib/presentation/widgets/search_bar.dart
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final String hintText;
  final TextEditingController? controller;

  const SearchBar({
    super.key,
    required this.onSubmitted,
    this.hintText = 'Buscar criptomoedas...',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
