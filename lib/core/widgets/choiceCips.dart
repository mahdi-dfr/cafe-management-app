import 'package:cafe_app/core/constants/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key, required this.choiceList, required this.onSelected});
  final List<String> choiceList;
  final ValueChanged<String>  onSelected;

  @override
  State<ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  int selectedDayIndex = 0;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.choiceList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isActive = index == selectedDayIndex;
          return ChoiceChip(
            label: Text(
              widget.choiceList[index],
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: isActive,
            onSelected: (isActive) {
              setState(() => selectedDayIndex = index);
              print( widget.choiceList[index],);
              widget.onSelected(widget.choiceList[index]);

            },
            selectedColor: AppColors.secondaryColor,
            backgroundColor: AppColors.tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}

