import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import '../widgets/error_box.dart';
import '../widgets/loading_box.dart';
import 'games_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<GameCategory>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    _futureCategories = _apiService.fetchCategories();
  }

  void _goToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
  }

  void _openCategory(GameCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GamesScreen(category: category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Vault'),
        actions: [
          IconButton(
            tooltip: 'Buscar',
            onPressed: _goToSearch,
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<GameCategory>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBox();
          }

          if (snapshot.hasError) {
            return ErrorBox(
              message: snapshot.error.toString(),
              onRetry: () => setState(_loadCategories),
            );
          }

          final categories = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Retro Games DB', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 6),
              const Text('Elige una categoría o busca un videojuego clásico.'),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _goToSearch,
                icon: const Icon(Icons.search_rounded),
                label: const Text('Buscar videojuego'),
              ),
              const SizedBox(height: 16),
              for (final category in categories)
                CategoryCard(
                  category: category,
                  onTap: () => _openCategory(category),
                ),
            ],
          );
        },
      ),
    );
  }
}
