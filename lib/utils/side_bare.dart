import 'package:flutter/material.dart';
import 'package:tools_manager/utils/tools_dashboard.dart';

class SideBare extends StatelessWidget {
  final Function(Widget) onSelectPage;

  const SideBare({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF98ddd8)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Image.asset("assets/images/logo.png", width: 150),
              Container(
                height: 150,
                child: const Center(
                  child: Text(
                    "Information",
                    style: TextStyle(fontSize: 24, color: Color(0xFFf0faff)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onSelectPage(const ToolsDashboard());
                },
                child: Container(
                  width: 175,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2e97b4),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tools",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFf0faff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
