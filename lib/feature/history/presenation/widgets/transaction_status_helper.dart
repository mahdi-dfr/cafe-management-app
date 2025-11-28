import 'package:flutter/material.dart';
import '../../../../core/resource/app_colors.dart';
import '../../../../muck_models/transaction_model.dart';

/// Helper class for transaction status
class TransactionStatusHelper {
  /// Get status color based on transaction status
  static Color getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return AppColors.success;
      case TransactionStatus.pending:
        return AppColors.warning;
      case TransactionStatus.failed:
        return AppColors.error;
      case TransactionStatus.cancelled:
        return AppColors.grey;
    }
  }

  /// Get status icon based on transaction status
  static IconData getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Icons.check_circle;
      case TransactionStatus.pending:
        return Icons.pending;
      case TransactionStatus.failed:
        return Icons.error;
      case TransactionStatus.cancelled:
        return Icons.cancel;
    }
  }

  /// Get status text based on transaction status
  static String getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'تکمیل شده';
      case TransactionStatus.pending:
        return 'در انتظار';
      case TransactionStatus.failed:
        return 'ناموفق';
      case TransactionStatus.cancelled:
        return 'لغو شده';
    }
  }
}
