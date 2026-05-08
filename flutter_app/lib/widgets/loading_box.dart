import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingBox extends StatelessWidget {
  final String text;

  const LoadingBox({
    super.key,
    this.text = 'Cargando datos...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppTheme.accent),
          const SizedBox(height: 18),
          Text(text),
        ],
      ),
    );
  }
}
