import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/error_box.dart';
import '../widgets/loading_box.dart';

class DetailScreen extends StatefulWidget {
  final int gameId;

  const DetailScreen({super.key, required this.gameId});

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
      appBar: AppBar(title: const Text('Detalle')),
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

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _apiService.imageUrl(game.image),
                  height: 210,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 210,
                    color: AppTheme.panelSoft,
                    child: const Icon(Icons.videogame_asset_rounded, size: 52),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(game.name, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text('${game.category} · ${game.platform} · ${game.year}'),
              const SizedBox(height: 18),
              _InfoRow(label: 'Desarrolladora', value: game.developer),
              _InfoRow(label: 'Valoración', value: game.rating.toStringAsFixed(1)),
              const SizedBox(height: 18),
              Text('Descripción', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(game.description ?? 'Sin descripción disponible.'),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppTheme.muted)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
