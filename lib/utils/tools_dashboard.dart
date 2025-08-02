import 'package:flutter/material.dart';
import 'package:tools_manager/utils/tools_list.dart';

class ToolsDashboard extends StatefulWidget {
  const ToolsDashboard({super.key});

  @override
  State<ToolsDashboard> createState() => _ToolsDashboardState();
}

class _ToolsDashboardState extends State<ToolsDashboard> {
  String? selectedOption1;
  String? selectedOption2;
  String textFieldValue = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 250,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 200,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF98ddd8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                textFieldValue = value;
                              });
                            },
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Search..",
                              hintStyle: TextStyle(
                                color: Color(0xBC000000),
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                  
                      _buildStyledDropdown(
                        value: selectedOption2,
                        hint: "Type",
                        items: ["All", "Machein", "Electric", "Light Wight"],
                        onChanged: (value) {
                          setState(() {
                            selectedOption2 = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      _buildStyledDropdown(
                        value: selectedOption1,
                        hint: "Status",
                        items: ["All", "Ready", "taken", "Broken", "Stolen"],
                        onChanged: (value) {
                          setState(() {
                            selectedOption1 = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ToolsList(
                  searchText: textFieldValue,
                  statusFilter: selectedOption1,
                  typeFilter: selectedOption2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStyledDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF98ddd8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xBC000000),
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const SizedBox.shrink(),
          dropdownColor: const Color(0xFF98ddd8),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
