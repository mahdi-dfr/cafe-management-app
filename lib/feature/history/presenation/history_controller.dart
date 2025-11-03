import 'package:get/get.dart';
import '../../../models/transaction_model.dart';

/// Controller for History Screen managing transactions
class HistoryController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var transactions = <TransactionModel>[].obs;
  var selectedTransaction = TransactionModel(
    id: '',
    title: '',
    date: DateTime.now(),
    amount: 0,
    status: TransactionStatus.pending,
    description: '',
    category: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  /// Load transactions from mock data
  void loadTransactions() {
    isLoading.value = true;
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      transactions.value = MockTransactions.getTransactions();
      isLoading.value = false;
    });
  }

  /// Set selected transaction and navigate to detail
  void selectTransaction(TransactionModel transaction) {
    selectedTransaction.value = transaction;
    Get.toNamed('/transaction-detail', arguments: transaction);
  }

  /// Get status color based on transaction status
  String getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }
}

