import 'package:cafe_app/core/constants/app_colors.dart' show AppColors;
import 'package:cafe_app/core/widgets/custom_text_field.dart';
import 'package:cafe_app/feature/home/presenation/screen/orders/cafe_menu_screen.dart';
import 'package:cafe_app/muck_models/models.dart';
import 'package:cafe_app/muck_models/orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/resource/route_management.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../controller/order_controller.dart';

class CafeTablesScreen extends StatefulWidget {
  const CafeTablesScreen({super.key});

  @override
  State<CafeTablesScreen> createState() => _CafeTablesScreenState();
}

class _CafeTablesScreenState extends State<CafeTablesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<TableModel> tables = List.generate(
    12,
    (index) => TableModel(
      number: index + 1,
      isOccupied: index % 3 == 0,
      orders: index % 3 == 0 ? ['Espresso', 'Latte', 'Cheesecake'] : [],
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              curve: Interval((index / tables.length), 1.0, curve: Curves.easeOutBack),
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
              child: table.isOccupied ? OrdersScreen(table: table) : CreateOrderScreen(table: table),
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
            BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 8)),
          ],
          border: Border.all(
            color: !table.isOccupied ? AppColors.surfaceColor : AppColors.primaryColor,
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
                      'میز ${table.number}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: !table.isOccupied ? Colors.white : AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  StatusDot(isOccupied: !table.isOccupied),
                ],
              ),

              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: table.isOccupied
                    ? Text(
                        '${table.orders.length} سفارش فعال',
                        key: const ValueKey('occupied'),
                        style: TextStyle(color: AppColors.secondaryColor),
                      )
                    : Text(
                        'در دسترس',
                        key: const ValueKey('free'),
                        style: TextStyle(color: AppColors.info, fontWeight: FontWeight.w600),
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
        color: isOccupied ? AppColors.surfaceColor : AppColors.primaryColor,
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
        title: Text('سفارش های ثبت شده - میز ${table.number}' , style: TextStyle(fontSize: 18),),
        backgroundColor: AppColors.backgroundColor,
      ),
      bottomNavigationBar: CustomConfirmButton(
        title: 'ویرایش سفارش',
        onPressed: () {
          Get.to(CafeMenuScreen());
        },
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: table.orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          return OrderItemShow(order: orders[index]);
        },
      ),
    );
  }
}

class CreateOrderScreen extends StatelessWidget {
  final TableModel table;

  CreateOrderScreen({super.key, required this.table});

  final _controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('سفارش جدید برای میز ${table.number}'),
        backgroundColor: AppColors.backgroundColor,
      ),
      bottomNavigationBar: CustomConfirmButton(
        title: 'ثبت نهایی سفارش',
        onPressed: () {
          Get.back();
        },
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _controller.guestName,
              label: 'نام و نام خانوادگی مهمان',
              icon: Icons.person,
              iconColor: AppColors.secondaryColor,
              fillColor: AppColors.cardBackground,
              borderColor: AppColors.primaryColor,
            ),

            SizedBox(height: 20),

            CustomTextField(
              controller: _controller.guestNumber,
              label: 'شماره تماس مهمان',
              icon: Icons.phone,
              iconColor: AppColors.secondaryColor,
              fillColor: AppColors.cardBackground,
              keyboardType: TextInputType.phone,
              borderColor: AppColors.primaryColor,
            ),

            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'سفارش ها',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),

                IconButton(
                  onPressed: () {
                    Get.to(CafeMenuScreen());
                  },
                  icon: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.secondaryColor),
                      Text(
                        'اضافه کردن سفارش',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  return OrderItemShow(order: orders[index]);
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 20);
                },
                itemCount: orders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemShow extends StatelessWidget {
  const OrderItemShow({super.key, required this.order});

  final String order;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.fastfood_sharp, color: AppColors.secondaryColor),
              SizedBox(width: 10),
              Text( order, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          Text('تعداد: 1', style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
