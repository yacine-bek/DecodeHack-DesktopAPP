import 'package:flutter/material.dart';
import 'package:tools_manager/utils/tools_dashboard.dart';
import 'package:tools_manager/utils/side_bare.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _currentPage = const ToolsDashboard(); // default page

  void _switchPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBare(onSelectPage: _switchPage),
          Expanded(child: _currentPage),
        ],
      ),
    );
  }
}
