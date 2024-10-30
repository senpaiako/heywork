import 'package:flutter/material.dart';

class QuickActionFormDialog extends StatelessWidget {
  final String title;

  const QuickActionFormDialog({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter $title Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Field 1',
              hintText: 'Enter data',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: 'Field 2',
              hintText: 'Enter data',
            ),
          ),
          if (title == 'Overtime') // Conditional example
            TextField(
              decoration: InputDecoration(
                labelText: 'Overtime Hours',
                hintText: 'Enter hours',
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle form submission here
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
