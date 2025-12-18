import 'package:cafe_app/core/constants/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';

class CafeTablesScreen extends StatefulWidget {
  const CafeTablesScreen({super.key});

  @override
  State<CafeTablesScreen> createState() => _CafeTablesScreenState();
}

class _CafeTablesScreenState extends State<CafeTablesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<TableModel> tables = List.generate(12, (index) => TableModel(
      number: index + 1,
      isOccupied: index % 3 == 0,
      orders: index % 3 == 0
          ? ['Espresso', 'Latte', 'Cheesecake']
          : [],
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('میزها', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: tables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final animation = CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (index / tables.length),
                1.0,
                curve: Curves.easeOutBack,
              ),
            );

            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: TableCard(table: tables[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TableCard extends StatelessWidget {
  final TableModel table;

  const TableCard({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (_, animation, __) => FadeTransition(
              opacity: animation,
              child: table.isOccupied
                  ? OrdersScreen(table: table)
                  : CreateOrderScreen(table: table),
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: table.isOccupied
                ? AppColors.surfaceColor
                : AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Table ${table.number}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  StatusDot(isOccupied: table.isOccupied),
                ],
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: table.isOccupied
                    ? Text(
                  '${table.orders.length} Active Orders',
                  key: const ValueKey('occupied'),
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                  ),
                )
                    : Text(
                  'Available',
                  key: const ValueKey('free'),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusDot extends StatelessWidget {
  final bool isOccupied;

  const StatusDot({super.key, required this.isOccupied});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: isOccupied
            ? AppColors.surfaceColor
            : AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  final TableModel table;

  const OrdersScreen({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Orders - Table ${table.number}'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: table.orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              table.orders[index],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}

class CreateOrderScreen extends StatelessWidget {
  final TableModel table;

  const CreateOrderScreen({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('New Order - Table ${table.number}'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {},
          child: const Text('Add Items'),
        ),
      ),
    );
  }
}

class TableModel {
  final int number;
  final bool isOccupied;
  final List<String> orders;

  TableModel({
    required this.number,
    required this.isOccupied,
    required this.orders,
  });
}


