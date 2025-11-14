import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const CafeStaffProfileApp());
}

class CafeStaffProfileApp extends StatelessWidget {
  const CafeStaffProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF9F6F2), // cream
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF221910), // background-dark

        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark, // respect the screenshot (dark)
      home: const StaffProfilePage(),
    );
  }
}

class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key});

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late final AnimationController _animController;

  final String profileImage =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAi-zvYSn8jLcnT_czJuPfBfe6aWgWbR04AQjaE67CMV7oJEkRuxjMctW_h5ZC8LKnhRpAWr6qbAnzkr7TzOWPvw48whW_8esAPtjAhJ3M81rykWTizxIoOMzO-9cVGMF_x0eQPpa0aZtKakMW_NKytTd5V9ksOAoz0mrRisHQxStuEWrxxLR76coK5F4wJik0cDCjRz3AW7gb5Y03Eb6ud9codG0npafe3SJlgv_ryVh-8SlUmg9NlOPD7RvHV62P1cRqO5iseZ7Y';

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // helper for glass card
  Widget glassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromRGBO(61, 44, 42, 0.28)
                : const Color.fromRGBO(255, 255, 255, 0.5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromRGBO(61, 44, 42, 0.35)
                  : const Color.fromRGBO(212, 187, 165, 0.15),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // small timeline item
  Widget timelineItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFD4BBA5).withOpacity(0.6)
                : const Color(0xFFD4BBA5).withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.brown[900]
                  : Colors.brown[900]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.brown[900],
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFFD4BBA5)
                          : Colors.brown[600],
                      fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }

  // calendar grid (simple)
  Widget calendarGrid() {
    // we'll show a cropped month like the HTML
    List<int?> days = [
      29, 30, 1, 2, 3, 4, 5, // first row
      6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19,
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('S', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('M', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('W', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('T', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('F', style: TextStyle(color: const Color(0xFFD4BBA5))),
            Text('S', style: TextStyle(color: const Color(0xFFD4BBA5))),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: days.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 6, crossAxisSpacing: 6),
          itemBuilder: (context, idx) {
            final val = days[idx];
            // mark special days 3,9,10,16 like screenshot
            final isCircle = val == 3 || val == 9 || val == 16;
            final isPrimary = val == 10;
            final textColor =
            Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.brown[900];
            if (val == null) {
              return const SizedBox();
            }
            if (isPrimary) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD47311), // primary orange
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.deepOrange.withOpacity(0.25), blurRadius: 6, offset: const Offset(0, 4))],
                ),
                alignment: Alignment.center,
                child: Text('$val', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              );
            } else if (isCircle) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFD4BBA5).withOpacity(0.45)
                      : const Color(0xFFD4BBA5).withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('$val', style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
              );
            } else {
              return Center(
                child: Text('$val', style: TextStyle(color: textColor)),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerTextColor = isDark ? Colors.white : Colors.brown[900];
    final subTextColor = isDark ? const Color(0xFFD4BBA5) : Colors.brown[400];

    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SafeArea(
        bottom: true,
        child: FadeTransition(
          opacity: _animController.drive(CurveTween(curve: Curves.easeOut)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top bar
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back,
                              color: isDark ? Colors.white : Colors.brown[900])),
                      const Spacer(),
                      Text('Staff Profile', style: TextStyle(color: headerTextColor, fontSize: 18, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert, color: isDark ? Colors.white : Colors.brown[900])),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Profile picture and name
                  Column(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 8))],
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(profileImage),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Alex Doe', style: TextStyle(color: headerTextColor, fontSize: 22, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('Head Barista', style: TextStyle(color: subTextColor, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Segmented control
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.brown.withOpacity(0.2) : const Color(0xFFEFECEC),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        _segmentButton(0, 'Info'),
                        _segmentButton(1, 'Responsibilities'),
                        _segmentButton(2, 'Notes'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Info Tab content (we'll show only Info like screenshot)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: _selectedTabIndex == 0
                        ? Column(
                      key: const ValueKey('info'),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Personal Details Card
                        glassCard(
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Personal Details',
                                  style: TextStyle(color: headerTextColor, fontSize: 18, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 12),
                              _twoColumnRow('Phone', '+1 (555) 123-4567', subTextColor!, headerTextColor!),
                              const Divider(color: Color(0xFFBBAA99), height: 18),
                              _twoColumnRow('Email', 'alex.doe@example.com', subTextColor!, headerTextColor!),
                              const Divider(color: Color(0xFFBBAA99), height: 18),
                              _twoColumnRow('Age', '28 years old', subTextColor!, headerTextColor!),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Work History timeline card
                        glassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Work History', style: TextStyle(color: headerTextColor, fontSize: 18, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 14),
                              // vertical line + items
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // timeline line
                                  Column(
                                    children: [
                                      Container(width: 2, height: 8, color: Colors.transparent),
                                      Container(width: 2, height: 60, color: const Color(0xFFD4BBA5).withOpacity(0.25)),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        timelineItem(Icons.flag, 'Hired', 'October 15, 2021'),
                                        const SizedBox(height: 12),
                                        timelineItem(Icons.star, 'Promoted to Head Barista', 'July 22, 2023'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Off-Days calendar card
                        glassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Off-Days', style: TextStyle(color: headerTextColor, fontSize: 18, fontWeight: FontWeight.w800)),
                                  Text('October 2024', style: TextStyle(color: subTextColor, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              calendarGrid(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 90),
                      ],
                    )
                        : _selectedTabIndex == 1
                        ? Container(
                      key: const ValueKey('resp'),
                      padding: const EdgeInsets.all(30),
                      child: Center(child: Text('Responsibilities (placeholder)', style: TextStyle(color: headerTextColor))),
                    )
                        : Container(
                      key: const ValueKey('notes'),
                      padding: const EdgeInsets.all(30),
                      child: Center(child: Text('Notes (placeholder)', style: TextStyle(color: headerTextColor))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD47311),
        onPressed: () {
          // edit pressed
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: const Icon(Icons.edit, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _segmentButton(int idx, String title) {
    final active = _selectedTabIndex == idx;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = idx;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 44,
          decoration: BoxDecoration(
            color: active
                ? (isDark ? const Color(0xFFD4BBA5).withOpacity(0.18) : const Color(0xFFD4BBA5).withOpacity(0.35))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  color: active
                      ? (isDark ? Colors.white : Colors.brown[900])
                      : (isDark ? const Color(0xFFD4BBA5) : Colors.brown[400]),
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _twoColumnRow(String left, String right, Color leftColor, Color rightColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(left, style: TextStyle(color: leftColor, fontSize: 14))),
          Text(right, style: TextStyle(color: rightColor, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
