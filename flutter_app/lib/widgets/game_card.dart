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
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                apiService.imageUrl(game.image),
                width: 92,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 92,
                  height: 72,
                  color: AppTheme.panelSoft,
                  child: const Icon(Icons.image_not_supported_rounded),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text('${game.platform} · ${game.year}'),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppTheme.accent, size: 18),
                      const SizedBox(width: 4),
                      Text(game.rating.toStringAsFixed(1)),
                      const SizedBox(width: 12),
                      Text(game.category),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
