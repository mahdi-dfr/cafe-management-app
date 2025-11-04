import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import '../../../models/transaction_model.dart';
import 'history_controller.dart';
import 'widgets/transaction_card.dart';

/// History screen displaying list of transactions
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'تاریخچه تراکنش‌ها',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.backgroundColor),
          );
        }

        if (controller.transactions.isEmpty) {
          return const EmptyTransactionState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.loadTransactions();
          },
          color: AppColors.backgroundColor,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) {
              final transaction = controller.transactions[index];
              return TransactionCard(transaction: transaction);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 16);
            },
          ),
        );
      }),
    );
  }
}

/// Empty transaction state widget
class EmptyTransactionState extends StatelessWidget {
  const EmptyTransactionState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 100,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 20),
          Text(
            'هنوز تراکنشی وجود ندارد',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          Text(
            'تاریخچه تراکنش‌های شما در اینجا نمایش داده می‌شود',
            style: TextStyle(fontSize: 14, color: AppColors.textHint),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
