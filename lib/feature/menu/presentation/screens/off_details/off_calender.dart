import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class OffCalender extends StatelessWidget {
  const OffCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('لیست آف پرسنل', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: GridView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   itemCount: days.length,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 7,
      //     mainAxisSpacing: 6,
      //     crossAxisSpacing: 6,
      //   ),
      //   itemBuilder: (context, idx) {
      //     final val = days[idx];
      //     final isCircle = val == 3 || val == 9 || val == 16;
      //     final isPrimary = val == 10;
      //     final textColor = Colors.white;
      //
      //     if (val == null) return const SizedBox();
      //
      //     if (isPrimary) {
      //       return Container(
      //         decoration: BoxDecoration(
      //           color: const Color(0xFFD47311),
      //           shape: BoxShape.circle,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.deepOrange.withOpacity(0.25),
      //               blurRadius: 6,
      //               offset: const Offset(0, 4),
      //             ),
      //           ],
      //         ),
      //         alignment: Alignment.center,
      //         child: Text(
      //           '$val',
      //           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      //         ),
      //       );
      //     } else if (isCircle) {
      //       return Container(
      //         decoration: BoxDecoration(
      //           color: const Color(0xFFD4BBA5).withOpacity(0.45),
      //           shape: BoxShape.circle,
      //         ),
      //         alignment: Alignment.center,
      //         child: Text(
      //           '$val',
      //           style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      //         ),
      //       );
      //     } else {
      //       return Center(
      //         child: Text('$val', style: TextStyle(color: textColor)),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
