import 'package:flutter/material.dart';
import 'package:pokedex/core/errors/app_error.dart';
import 'package:pokedex/core/l10n/l10n.dart';
import 'package:pokedex/core/theme/themes.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final dynamic error;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final l10n = AppLocalizations.of(context);

    String errorMessage;
    if (error is NetworkError) {
      errorMessage = l10n.networkErrorMessage;
    } else if (error is DatabaseError) {
      errorMessage = l10n.databaseErrorMessage;
    } else {
      errorMessage = l10n.unknownErrorMessage;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.error),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            style: theme.titleMedium.copyWith(color: theme.error),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(theme.error),
              ),
              onPressed: onRetry,
              child: Text(l10n.retry),
            ),
          ],
        ],
      ),
    );
  }
}
