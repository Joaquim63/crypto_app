// lib/presentation/widgets/custom_search_bar.dart
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'Pesquisar...',
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  String _currentQuery = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmitted(String query) {
    if (query.trim().isNotEmpty && query != _currentQuery) {
      _currentQuery = query.trim();
      widget.onSearch(_currentQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _currentQuery = '';
                    widget.onSearch(''); // Limpa a pesquisa
                    FocusScope.of(context).unfocus(); // Esconde o teclado
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor:
              Theme.of(context).inputDecorationTheme.fillColor ??
              Colors.grey[200],
        ),
        onChanged: (value) {
          setState(() {
            // Atualiza o UI para mostrar/esconder o botão de limpar
          });
        },
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
