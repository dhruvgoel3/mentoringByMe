import 'package:flutter/material.dart';
import 'package:mentoring_meet_1/FirstPage.dart';
import 'package:mentoring_meet_1/HomePage.dart';
import 'package:mentoring_meet_1/SecondPage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int tabIndex = 0;
  List<Widget> tabItems = [Homepage(), Firstpage(), Secondpage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabItems[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HomePage"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "SearchPage",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "ThirdPage"),
        ],
      ),
    );
  }
}
