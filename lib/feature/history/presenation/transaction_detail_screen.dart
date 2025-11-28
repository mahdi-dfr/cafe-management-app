import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/resource/app_colors.dart';
import '../../../models/transaction_model.dart';
import 'widgets/transaction_detail_row.dart';
import 'widgets/transaction_status_helper.dart';

/// Transaction detail screen with hero animation
class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'جزئیات تراکنش',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Hero Transaction Card
              Hero(
                tag: 'transaction_${transaction.id}',
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Status Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: TransactionStatusHelper.getStatusColor(
                            transaction.status,
                          ).withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          TransactionStatusHelper.getStatusIcon(
                            transaction.status,
                          ),
                          color: TransactionStatusHelper.getStatusColor(
                            transaction.status,
                          ),
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Transaction Title
                      Text(
                        transaction.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 20),
                      // Amount
                      Text(
                        '${transaction.amount.toStringAsFixed(2)} تومان',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: TransactionStatusHelper.getStatusColor(
                            transaction.status,
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 20),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: TransactionStatusHelper.getStatusColor(
                            transaction.status,
                          ).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          TransactionStatusHelper.getStatusText(
                            transaction.status,
                          ),
                          style: TextStyle(
                            fontSize: 16,
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
                ),
              ),
              // Details Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اطلاعات تراکنش',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const Divider(height: 30),
                    TransactionDetailRow(
                      label: 'شناسه تراکنش',
                      value: transaction.id,
                    ),
                    const SizedBox(height: 16),
                    TransactionDetailRow(
                      label: 'دسته‌بندی',
                      value: transaction.category,
                    ),
                    const SizedBox(height: 16),
                    TransactionDetailRow(
                      label: 'تاریخ',
                      value: 'test',
                    ),
                    const SizedBox(height: 16),
                    TransactionDetailRow(
                      label: 'زمان',
                      value: 'test',
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      'توضیحات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
