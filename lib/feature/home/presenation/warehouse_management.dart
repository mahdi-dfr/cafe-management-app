import 'package:cafe_app/core/app_colors.dart';
import 'package:cafe_app/feature/home/presenation/controller/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WarehouseManagementScreen extends StatefulWidget {
  const WarehouseManagementScreen({super.key});

  @override
  State<WarehouseManagementScreen> createState() =>
      _WarehouseManagementScreenState();
}

class _WarehouseManagementScreenState extends State<WarehouseManagementScreen> {
  int _selectedSegment = 0;

  final List<WarehouseItem> _physicalCommodities = [
    const WarehouseItem(
      title: 'Coffee Grinder',
      subtitle: '2 units remaining',
      price: '12,500,000 ریال',
      category: 'Physical',
      quantityLabel: '2 units',
    ),
    const WarehouseItem(
      title: 'Espresso Machine',
      subtitle: '1 unit in stock',
      price: '48,000,000 ریال',
      category: 'Physical',
      quantityLabel: '1 unit',
    ),
  ];

  final List<WarehouseItem> _edibleCommodities = [
    const WarehouseItem(
      title: 'Ethiopia Coffee Beans',
      subtitle: '25 kg remaining',
      price: '2,500,000 ریال',
      category: 'Edible',
      quantityLabel: '25 kg',
    ),
    const WarehouseItem(
      title: 'Vanilla Syrup',
      subtitle: '8 bottles remaining',
      price: '950,000 ریال',
      category: 'Edible',
      quantityLabel: '8 bottles',
    ),
    const WarehouseItem(
      title: 'Whole Milk',
      subtitle: '12 liters remaining',
      price: '720,000 ریال',
      category: 'Edible',
      quantityLabel: '12 L',
    ),
  ];

  List<WarehouseItem> get _currentList =>
      _selectedSegment == 0 ? _physicalCommodities : _edibleCommodities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('مدیریت انبار'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => Get.to( AddCommodityScreen()),
        child: Icon(Icons.add, color: AppColors.backgroundColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'مدیریت کامل موجودی انبار',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 20),
              WarehouseSegmentedFilter(
                segments: const ['کالاهای فیزیکی', 'مواد خوراکی'],
                selectedIndex: _selectedSegment,
                onChanged: (index) => setState(() => _selectedSegment = index),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CommodityListSection(
                  items: _currentList,
                  onTap: (item) =>
                      Get.to(() => CommodityDetailsScreen(item: item)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WarehouseSegmentedFilter extends StatelessWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const WarehouseSegmentedFilter({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: segments.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final bool active = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.primaryColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: active ? AppColors.primaryColor : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    color: active ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CommodityListSection extends StatelessWidget {
  final List<WarehouseItem> items;
  final ValueChanged<WarehouseItem> onTap;

  const CommodityListSection({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = items[index];
        return CommodityCard(item: item, onTap: () => onTap(item));
      },
    );
  }
}

class CommodityCard extends StatelessWidget {
  final WarehouseItem item;
  final VoidCallback onTap;

  const CommodityCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Icon(Icons.inventory, color: AppColors.secondaryColor, size: 30,),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.quantityLabel,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommodityDetailsScreen extends StatelessWidget {
  final WarehouseItem item;

  const CommodityDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('جزئیات کالا'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommodityDetailHeader(item: item),
            const SizedBox(height: 18),
            CommodityDetailSection(
              title: 'توضیحات',
              child: Text(
                'توضیحات دقیق درباره ${item.title}. اطلاعاتی درباره کیفیت، نحوه نگهداری و موارد استفاده در منوی کافه.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.4),
              ),
            ),
            const SizedBox(height: 16),
            CommodityDetailSection(
              title: 'موجودی و قیمت',
              child: Row(
                children: [
                  Expanded(
                    child: _MiniStatCard(
                      label: 'موجودی فعلی',
                      value: item.quantityLabel,
                      icon: Icons.inventory,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MiniStatCard(
                      label: 'قیمت واحد',
                      value: item.price,
                      icon: Icons.attach_money,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'ذخیره تغییرات',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommodityDetailHeader extends StatelessWidget {
  final WarehouseItem item;

  const CommodityDetailHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Icon(Icons.inventory),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(item.category, style: TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}

class CommodityDetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const CommodityDetailSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.tertiaryColor,
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


class AddCommodityScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;

  final List<String> _categories = ['ابزار فیزیکی', 'مواد خوراکی', 'بسته بندی'];
  final _controller = Get.find<InventoryController>();

  AddCommodityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('افزودن کالای جدید'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              CafeTextFormField(
                controller: _controller.nameController,
                label: 'نام کالا',
                icon: Icons.inventory_rounded,
                validator: (value) => value == null || value.isEmpty
                    ? 'نام کالا را وارد کنید'
                    : null,
              ),
              const SizedBox(height: 16),
              CafeTextFormField(
                controller: _controller.priceController,
                label: 'قیمت',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'قیمت را وارد کنید' : null,
              ),
              const SizedBox(height: 16),
              CafeTextFormField(
                controller: _controller.descriptionController,
                label: 'توضیحات',
                icon: Icons.description_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              CategoryDropdown(
                label: 'دسته‌بندی',
                categories: _categories,
                value: _selectedCategory,
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;

                  if (_selectedCategory == null) {
                    Get.snackbar(
                      'هشدار',
                      'دسته‌بندی را انتخاب کنید',
                      backgroundColor: AppColors.cardBackground,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  Get.back();
                },
                child: const Text(
                  'ذخیره اطلاعات',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final String label;
  final List<String> categories;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.label,
    required this.categories,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.cardBackground,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white12),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.cardBackground,
          iconEnabledColor: AppColors.textSecondary,
          borderRadius: BorderRadius.circular(18),
          items: categories
              .map(
                (cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat, style: const TextStyle(color: Colors.white)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CafeTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const CafeTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textDirection: TextDirection.rtl,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primaryColor),
            filled: true,
            fillColor: AppColors.cardBackground,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class WarehouseItem {
  final String title;
  final String subtitle;
  final String price;
  final String quantityLabel;
  final String category;

  const WarehouseItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantityLabel,
    required this.category,
  });
}
