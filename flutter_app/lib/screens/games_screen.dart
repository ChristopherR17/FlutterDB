import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/game.dart';
import '../services/api_service.dart';
import '../widgets/error_box.dart';
import '../widgets/game_card.dart';
import '../widgets/loading_box.dart';
import 'detail_screen.dart';

class GamesScreen extends StatefulWidget {
  final GameCategory category;

  const GamesScreen({super.key, required this.category});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Game>> _futureGames;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  void _loadGames() {
    _futureGames = _apiService.fetchGamesByCategory(widget.category.name);
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
      appBar: AppBar(title: Text(widget.category.name)),
      body: FutureBuilder<List<Game>>(
        future: _futureGames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBox();
          }

          if (snapshot.hasError) {
            return ErrorBox(
              message: snapshot.error.toString(),
              onRetry: () => setState(_loadGames),
            );
          }

          final games = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(widget.category.description),
              const SizedBox(height: 16),
              for (final game in games)
                GameCard(
                  game: game,
                  apiService: _apiService,
                  onTap: () => _openDetail(game),
                ),
            ],
          );
        },
      ),
    );
  }
}
