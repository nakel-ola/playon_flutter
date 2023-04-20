import 'package:flutter/material.dart';

import '../../../widgets/custom_chip.dart';

class HistoryCard extends StatelessWidget {
  final List<String> history;
  final Function(String) onDelete;
  final Function(String) onTap;

  const HistoryCard({
    super.key,
    required this.history,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("History", style: TextStyle(fontSize: 18.0)),
          ),
          Wrap(
            children: history
                .map(
                  (e) => CustomChip(
                    label: e,
                    checked: false,
                    onDeleted: () => onDelete(e),
                    onTap: () => onTap(e),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
