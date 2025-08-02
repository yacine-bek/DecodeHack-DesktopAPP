import 'package:flutter/material.dart';
import 'package:tools_manager/classes/Tool.dart';

class ToolTile extends StatelessWidget {
  final Tool tool;
  final int index;
  const ToolTile({super.key, required this.tool, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF47c2c9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text("$index.", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          Text(
            tool.name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
          Spacer(),
          SizedBox(
            width: 200,
            child: Center(
              child: Text(
                tool.type,
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Center(
              child: Text(
                tool.status,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
