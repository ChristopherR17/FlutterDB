import 'dart:async';

import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/game_card.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<Game> _results = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(value));
  }

  Future<void> _search(String query) async {
    final cleanQuery = query.trim();

    if (cleanQuery.isEmpty) {
      setState(() {
        _results = [];
        _errorMessage = null;
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _apiService.searchGames(cleanQuery);
      if (!mounted) return;
      setState(() => _results = data);
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(gameId: game.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Busca: mario, sega, arcade, 1991...',
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: AppTheme.accent)),
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(color: AppTheme.accent),
            ),
          if (!_isLoading && _controller.text.trim().isNotEmpty && _results.isEmpty && _errorMessage == null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.panel,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('No se han encontrado resultados.'),
            ),
          for (final game in _results)
            GameCard(
              game: game,
              apiService: _apiService,
              onTap: () => _openDetail(game),
            ),
        ],
      ),
    );
  }
}
