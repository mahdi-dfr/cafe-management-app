// Creative Cafe Menu & Order UI with Animations
// Uses custom color palette, category sections, animated item selection

import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CafeMenuScreen extends StatefulWidget {
  const CafeMenuScreen({super.key});

  @override
  State<CafeMenuScreen> createState() => _CafeMenuScreenState();
}

class _CafeMenuScreenState extends State<CafeMenuScreen>
    with TickerProviderStateMixin {
  final Map<String, List<MenuItemModel>> menu = {
    'Hot Drinks': [
      MenuItemModel('Espresso', 1, true, '☕'),
      MenuItemModel('Latte', 1, true, '🥛'),
    ],
    'Cold Drinks': [
      MenuItemModel('Iced Coffee', 1, false, '🧊'),
      MenuItemModel('Lemonade', 1, true, '🍋'),
    ],
    'Food': [
      MenuItemModel('Burger', 1, true, '🍔'),
      MenuItemModel('Pasta', 1, false, '🍝'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Menu & Order'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...menu.entries.map(
                (category) => _CategorySection(category.key, category.value),
          ),
          const SizedBox(height: 32),
          _SubmitOrderButton(),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final List<MenuItemModel> items;

  const _CategorySection(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        ...items.map((item) => _MenuItemTile(item)).toList(),
      ],
    );
  }
}

class _MenuItemTile extends StatefulWidget {
  final MenuItemModel item;

  const _MenuItemTile(this.item);

  @override
  State<_MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<_MenuItemTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scale = Tween(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
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
                color: widget.item.selected
                    ? AppColors.primaryColor
                    : AppColors.surfaceColor,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  widget.item.icon,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.item.available ? 'Available' : 'Out of stock',
                        style: TextStyle(
                          color: widget.item.available
                              ? AppColors.secondaryColor
                              : Colors.redAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.item.selected)
                  _QuantitySelector(item: widget.item),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final MenuItemModel item;

  const _QuantitySelector({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QtyButton('-', () => item.quantity--),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        _QtyButton('+', () => item.quantity++),
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
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class _SubmitOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      onPressed: () {},
      child: const Text('Submit Order', style: TextStyle(fontSize: 18)),
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

