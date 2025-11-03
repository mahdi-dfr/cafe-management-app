/// Transaction model representing user transaction data
class TransactionModel {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final TransactionStatus status;
  final String description;
  final String category;

  TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.description,
    required this.category,
  });

  /// Factory constructor to create a transaction from JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
        orElse: () => TransactionStatus.pending,
      ),
      description: json['description'],
      category: json['category'],
    );
  }

  /// Convert transaction to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'amount': amount,
      'status': status.toString().split('.').last,
      'description': description,
      'category': category,
    };
  }
}

/// Transaction status enum
enum TransactionStatus {
  pending,
  completed,
  cancelled,
  failed,
}

/// Mock transaction data for demonstration
class MockTransactions {
  static List<TransactionModel> getTransactions() {
    return [
      TransactionModel(
        id: '1',
        title: 'Coffee Purchase',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: 12.50,
        status: TransactionStatus.completed,
        description: 'Purchased 2 cappuccinos from Main Street Cafe',
        category: 'Food & Beverages',
      ),
      TransactionModel(
        id: '2',
        title: 'Pastry Order',
        date: DateTime.now().subtract(const Duration(days: 3)),
        amount: 8.99,
        status: TransactionStatus.completed,
        description: 'Ordered chocolate croissant and blueberry muffin',
        category: 'Food & Beverages',
      ),
      TransactionModel(
        id: '3',
        title: 'Gift Card Refund',
        date: DateTime.now().subtract(const Duration(days: 5)),
        amount: 50.00,
        status: TransactionStatus.completed,
        description: 'Refund for unused gift card balance',
        category: 'Refund',
      ),
      TransactionModel(
        id: '4',
        title: 'Lunch Combo',
        date: DateTime.now().subtract(const Duration(days: 7)),
        amount: 18.75,
        status: TransactionStatus.pending,
        description: 'Lunch combo with coffee and sandwich',
        category: 'Food & Beverages',
      ),
      TransactionModel(
        id: '5',
        title: 'Failed Payment',
        date: DateTime.now().subtract(const Duration(days: 10)),
        amount: 25.00,
        status: TransactionStatus.failed,
        description: 'Payment declined due to insufficient funds',
        category: 'Food & Beverages',
      ),
      TransactionModel(
        id: '6',
        title: 'Online Order',
        date: DateTime.now().subtract(const Duration(days: 12)),
        amount: 32.40,
        status: TransactionStatus.cancelled,
        description: 'Online order cancelled due to unavailability',
        category: 'Food & Beverages',
      ),
    ];
  }
}

