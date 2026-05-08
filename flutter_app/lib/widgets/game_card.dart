import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  final ApiService apiService;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppTheme.panel,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            apiService.imageUrl(game.image),
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 64,
              height: 64,
              color: AppTheme.panelSoft,
              child: const Icon(Icons.videogame_asset_rounded),
            ),
          ),
        ),
        title: Text(game.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text('${game.platform} · ${game.year} · ${game.category}'),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
