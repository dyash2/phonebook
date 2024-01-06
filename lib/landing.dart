import 'package:contacts_app/Groups/group.dart';
import 'package:contacts_app/views/home.dart';
import 'package:flutter/material.dart';

class Target extends StatefulWidget {
  const Target({Key? key}) : super(key: key);

  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Homepage(),
    Group(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Group',
          ),
        ],
      ),
    );
  }
}


