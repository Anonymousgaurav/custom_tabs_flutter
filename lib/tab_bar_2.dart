import 'dart:math' as math;

import 'package:flutter/material.dart';

const kPageTitle = 'Settings';
const kLabels = ["Edit Profile", "Accounts"];
const kTabBgColor = Color(0xFF8F32A9);
const kTabFgColor = Colors.white;

class CustomTabPage extends StatefulWidget {
  const CustomTabPage({Key? key}) : super(key: key);

  @override
  _CustomTabPageState createState() => _CustomTabPageState();
}

class _CustomTabPageState extends State<CustomTabPage> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<int> _ids = [1, 0];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kPageTitle),
        elevation: 0,
      ),
      body: Column(
        children: [
          MyTabBar(
            controller: _controller,
            labels: kLabels,
            backgroundColor: kTabBgColor,
            foregroundColor: kTabFgColor,
            activeBackgroundColor: Colors.red,
            activeForegroundColor: Colors.green,
            fontSize: 20,
            onTabTapped: (id) {
              setState(() {
                _ids = _ids.reversed.toList();
              });
            },
            ids: _ids,
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                Center(child: Text(kLabels[0])),
                Center(child: Text(kLabels[1])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> labels;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final double fontSize;
  final Function(int) onTabTapped;
  final List<int> ids;

  const MyTabBar({
    Key? key,
    required this.controller,
    required this.labels,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.fontSize,
    required this.onTabTapped,
    required this.ids,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 100 / 18,
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Stack(
          fit: StackFit.expand,
          children: ids.map((id) {
            final active = controller.index == id;
            return MyTab(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              activeBackgroundColor: activeBackgroundColor,
              activeForegroundColor: activeForegroundColor,
              fontSize: fontSize,
              active: active,
              reversed: id == 1,
              label: labels[id],
              onTap: () {
                controller.animateTo(id);
                onTabTapped(id);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final double fontSize;
  final bool active;
  final bool reversed;
  final String label;
  final VoidCallback onTap;

  Color get bgColor =>
      active ? activeBackgroundColor : backgroundColor;
  Color get fgColor =>
      active ? activeForegroundColor : foregroundColor;

  const MyTab({
    Key? key,
    required this.active,
    this.reversed = false,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.fontSize,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: reversed
                ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(painter: TabPainter(color: bgColor)),
            )
                : CustomPaint(painter: TabPainter(color: bgColor)),
          ),
        ),
        Align(
          alignment: reversed ? Alignment.centerRight : Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: .5,
            heightFactor: 1,
            child: TextButton(
              onPressed: active ? null : onTap,
              child: Text(
                label,
                style: TextStyle(color: fgColor, fontSize: fontSize),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TabPainter extends CustomPainter {
  final Color? color;

  TabPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, .5 * size.height);
    path.quadraticBezierTo(0, 0, .1 * size.width, 0);
    path.lineTo(.48 * size.width, 0);
    path.quadraticBezierTo(
        .512 * size.width, 0, .52 * size.width, .1 * size.height);
    path.lineTo(.57 * size.width, .83 * size.height);
    path.quadraticBezierTo(
        .58 * size.width, .9 * size.height, .59 * size.width, .9 * size.height);
    path.lineTo(size.width, .9 * size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
