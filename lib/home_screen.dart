import 'package:flutter/material.dart';
import 'package:todo_app/tabs/settings/settings_tab.dart';
import 'package:todo_app/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo_app/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCurrentIndex = 0;
  List<Widget> tabs = const [
    TasksTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => const AddTaskBottomSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: tabs[selectedCurrentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // new
        padding: EdgeInsets.zero,
        // new
        child: BottomNavigationBar(
          currentIndex: selectedCurrentIndex,
          onTap: (index) {
            setState(() {
              selectedCurrentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 32,
              ),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 32,
                ),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
