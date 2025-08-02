import 'package:flutter/material.dart';
import 'package:tools_manager/classes/Manager.dart';
import 'package:tools_manager/utils/tool_tile.dart';

class ToolsList extends StatefulWidget {
  final String searchText;
  final String? statusFilter;
  final String? typeFilter;

  const ToolsList({
    super.key,
    required this.searchText,
    required this.statusFilter,
    required this.typeFilter,
  });

  @override
  State<ToolsList> createState() => _ToolsListState();
}

class _ToolsListState extends State<ToolsList> {
  final TextEditingController nameController = TextEditingController();
  String? selectedOption;
  String? selectedStatus;
  bool isHoveringCancel = false;
  bool isHoveringSubmit = false;

  @override
  Widget build(BuildContext context) {
    final allTools = Manager().getTools().values.toList();

    final filteredTools = allTools.where((tool) {
      final matchesSearch = tool.name.toLowerCase().contains(
            widget.searchText.toLowerCase(),
          );
      final matchesStatus = widget.statusFilter == null ||
              widget.statusFilter == "All"
          ? true
          : tool.status == widget.statusFilter;
      final matchesType =
          widget.typeFilter == null || widget.typeFilter == "All"
              ? true
              : tool.type == widget.typeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredTools.length,
              itemBuilder: (context, index) {
                final tool = filteredTools[index];
                return ToolTile(tool: tool, index: index);
              },
            ),
          ),
          Container(
            height: 500,
            width: 412,
            decoration: BoxDecoration(
              color: const Color(0xFF47c2c9),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'ADD TOOL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF98ddd8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      hint: const Text(
                        "Type",
                        style: TextStyle(
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
                      items: ["Machein", "Electric", "Light Wight"]
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedOption = value!);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF98ddd8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedStatus,
                      hint: const Text(
                        "Status",
                        style: TextStyle(
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
                      items: ["Ready", "In Use", "Maintenance", "Retired"]
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedStatus = value!);
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => isHoveringCancel = true),
                      onExit: (_) => setState(() => isHoveringCancel = false),
                      child: GestureDetector(
                        onTap: () {
                          nameController.clear();
                          selectedOption = null;
                          selectedStatus = null;
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isHoveringCancel
                                ? const Color.fromARGB(255, 115, 216, 221)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('Cancel',
                                style: TextStyle(fontSize: 24)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => isHoveringSubmit = true),
                      onExit: (_) => setState(() => isHoveringSubmit = false),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedOption != null &&
                              selectedStatus != null &&
                              nameController.text.isNotEmpty) {
                            Manager().addTool(
                              category: selectedOption!,
                              name: nameController.text.trim(),
                              status: selectedStatus!,
                            );
                            nameController.clear();
                            selectedOption = null;
                            selectedStatus = null;
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isHoveringSubmit
                                ? const Color(0xFF5ccbb2)
                                : const Color(0xFF6edbc6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
