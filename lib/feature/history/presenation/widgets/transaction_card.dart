import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../muck_models/transaction_model.dart';
import '../history_controller.dart';
import 'transaction_status_helper.dart';

/// Transaction card widget
class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.find();

    return Hero(
      tag: 'transaction_${transaction.id}',
      child: InkWell(
        // onTap: () => controller.selectTransaction(transaction),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.tertiaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Status Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: TransactionStatusHelper.getStatusColor(
                    transaction.status,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  TransactionStatusHelper.getStatusIcon(transaction.status),
                  color: TransactionStatusHelper.getStatusColor(
                    transaction.status,
                  ),
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              // Transaction Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'test',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transaction.category,
                      style: TextStyle(fontSize: 12, color: AppColors.textHint),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              // Amount & Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transaction.amount.toStringAsFixed(2)} تومان',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TransactionStatusHelper.getStatusColor(
                        transaction.status,
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: TransactionStatusHelper.getStatusColor(
                        transaction.status,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      TransactionStatusHelper.getStatusText(transaction.status),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: TransactionStatusHelper.getStatusColor(
                          transaction.status,
                        ),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
