import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/tabs/settings.dart';
import 'package:to_do/tabs/tasks.dart';

import 'add task_bottom sheet.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = "Home";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffDFECDB),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "ToDo",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context,
              isScrollControlled: true,
              builder:(context){
               return Padding(
                 padding:EdgeInsets.only(
                   bottom: MediaQuery.of(context).viewInsets.bottom,
                 ),
                 child: AddTaskBottomSheet(),
               );
              },
          );
        },

        backgroundColor: Colors.blue,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 35),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 8,
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      body:tabs[selectedIndex] ,
    );
  }
  List<Widget>tabs=[TasksTab(),SettingsTab()];
}

