import 'package:flutter/material.dart';

class DialogueListTile extends StatelessWidget {
  const DialogueListTile({
    super.key,
    required this.title,
    required this.preview,
    required this.badgeText,
    required this.onTap,
  });

  final String title;
  final String preview;
  final String badgeText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(preview, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 4.0),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
