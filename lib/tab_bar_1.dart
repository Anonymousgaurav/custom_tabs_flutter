import 'package:flutter/material.dart';


class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  // List of tab titles
  final List<String> _tabs = ['Home', 'Profile', 'Settings'];

  // Method to build each tab button
  Widget _buildTab(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Add the indicator below the tab text
            Container(
              height: 4.0,
              width: 80.0,
              color: _selectedIndex == index ? Colors.red : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the content for each tab
  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return Center(child: Text('Home Content'));
      case 1:
        return Center(child: Text('Profile Content'));
      case 2:
        return Center(child: Text('Settings Content'));
      default:
        return Center(child: Text('Home Content'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 16.0, // Space between tabs
            children: List.generate(_tabs.length, (index) => _buildTab(index)),
          ),
        ),
        Expanded(
          child: _buildTabContent(),
        ),
      ],
    );
  }
}
