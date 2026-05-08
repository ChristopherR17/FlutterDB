import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
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
      MaterialPageRoute(
        builder: (_) => GamesScreen(category: category),
      ),
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

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Retro Games DB',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Explora videojuegos clásicos por género y consulta sus detalles desde un servidor NodeJS.',
                      ),
                      const SizedBox(height: 18),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: _goToSearch,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.panelSoft,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search_rounded, color: AppTheme.accent),
                              SizedBox(width: 12),
                              Expanded(child: Text('Buscar por nombre, consola, año o desarrolladora')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverGrid.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 260,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                      onTap: () => _openCategory(categories[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
