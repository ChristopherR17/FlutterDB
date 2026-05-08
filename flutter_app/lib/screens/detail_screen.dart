import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/error_box.dart';
import '../widgets/loading_box.dart';

class DetailScreen extends StatefulWidget {
  final int gameId;

  const DetailScreen({
    super.key,
    required this.gameId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<Game> _futureGame;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  void _loadDetail() {
    _futureGame = _apiService.fetchGameDetail(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Game>(
        future: _futureGame,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBox(text: 'Cargando detalle...');
          }

          if (snapshot.hasError) {
            return ErrorBox(
              message: snapshot.error.toString(),
              onRetry: () => setState(_loadDetail),
            );
          }

          final game = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(game.name),
                  background: Image.network(
                    _apiService.imageUrl(game.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _InfoChip(icon: Icons.category_rounded, text: game.category),
                          _InfoChip(icon: Icons.calendar_month_rounded, text: '${game.year}'),
                          _InfoChip(icon: Icons.sports_esports_rounded, text: game.platform),
                          _InfoChip(icon: Icons.star_rounded, text: game.rating.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('Desarrolladora', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(game.developer),
                      const SizedBox(height: 24),
                      Text('Descripción', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(game.description ?? 'Sin descripción disponible.'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.panel,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppTheme.accent),
          const SizedBox(width: 7),
          Text(text),
        ],
      ),
    );
  }
}
