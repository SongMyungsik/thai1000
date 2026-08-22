import 'package:flutter/material.dart';

class WordListTile extends StatelessWidget {
  const WordListTile({
    super.key,
    required this.thai,
    required this.subtitle,
    required this.badgeText,
    required this.onTap,
  });

  final String thai;
  final String subtitle;
  final String badgeText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(thai, style: const TextStyle(fontSize: 22.0)),
        subtitle: Text(subtitle),
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
