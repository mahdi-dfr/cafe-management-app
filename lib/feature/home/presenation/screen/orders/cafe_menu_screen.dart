// Creative Cafe Menu & Order UI with Animations
// Uses custom color palette, category sections, animated item selection

import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/choiceCips.dart';
import 'package:cafe_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cafe_menu_controller.dart';

class CafeMenuScreen extends StatelessWidget {
  CafeMenuScreen({super.key});

  final Map<String, List<MenuItemModel>> menu = {
    'نوشیدنی گرم': [MenuItemModel('اسپرسو', 1, true, '☕'), MenuItemModel('لته', 1, true, '🥛')],
    'نوشیدنی سرد': [MenuItemModel('آیس کارامل ماکیاتو', 1, false, '🧊'), MenuItemModel('لیموناد', 1, true, '🍋')],
    'غذا': [MenuItemModel('استیک', 1, true, '🍔'), MenuItemModel('پاستا پنه آلفردو', 1, false, '🍝')],
  };

  final _controller = Get.find<CafeMenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('منوی کافه'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      bottomNavigationBar: CustomConfirmButton(
        title: 'ثبت',
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
        onPressed: () {
          Get.back();
        },
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChoiceChips(
            choiceList: menu.keys.toList(),
            onSelected: (data) {
              _controller.menuCategory.value = data;
              print(menu[_controller.menuCategory.value]!.length);
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Obx(
              () => Text(
                _controller.menuCategory.value,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              final items = menu[_controller.menuCategory.value]!;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  return _MenuItemTile(items[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MenuItemTile extends StatefulWidget {
  final MenuItemModel item;

  const _MenuItemTile(this.item);

  @override
  State<_MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<_MenuItemTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _scale = Tween(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSelect() {
    if (!widget.item.available) return;
    setState(() => widget.item.selected = !widget.item.selected);
    widget.item.selected ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.item.available ? 1 : 0.4,
      child: GestureDetector(
        onTap: _toggleSelect,
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.item.selected ? AppColors.primaryColor : AppColors.surfaceColor,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 6)),
              ],
            ),
            child: Row(
              children: [
                Text(widget.item.icon, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.name, style: const TextStyle(fontSize: 18, color: Colors.white)),
                      const SizedBox(height: 6),
                      Text(
                        widget.item.available ? 'موجود' : 'اتمام موجودی',
                        style: TextStyle(
                          color: widget.item.available ? AppColors.secondaryColor : Colors.redAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.item.selected) _QuantitySelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final _controller = Get.find<CafeMenuController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QtyButton('-', () => _controller.itemQuantity.value--),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Obx((){
            return Text(_controller.itemQuantity.value.toString(), style: const TextStyle(color: Colors.white));
          }),
        ),
        _QtyButton('+', () => _controller.itemQuantity.value++),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QtyButton(this.label, this.onTap);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: AppColors.surfaceColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


class MenuItemModel {
  final String name;
  int quantity;
  final bool available;
  final String icon;
  bool selected = false;

  MenuItemModel(this.name, this.quantity, this.available, this.icon);
}
