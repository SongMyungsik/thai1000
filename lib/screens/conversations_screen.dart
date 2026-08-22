import 'package:flutter/material.dart';

import '../data/conversations_data.dart';
import '../models/conversation.dart';
import '../services/tts_service.dart';
import '../widgets/class_filter_chips.dart';
import '../widgets/dialogue_list_tile.dart';
import 'conversation_detail_screen.dart';

final _categoryFilterLabels = [
  '전체',
  ...ConversationCategory.values.map((c) => c.label),
];

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  int _filterIndex = 0;

  List<Dialogue> get _filteredDialogues {
    if (_filterIndex == 0) return dialogues;
    final targetCategory = ConversationCategory.values[_filterIndex - 1];
    return dialogues.where((d) => d.category == targetCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회화')),
      body: Column(
        children: [
          ClassFilterChips(
            labels: _categoryFilterLabels,
            selectedIndex: _filterIndex,
            onSelected: (i) => setState(() => _filterIndex = i),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              itemCount: _filteredDialogues.length,
              itemBuilder: (context, index) {
                final dialogue = _filteredDialogues[index];
                return DialogueListTile(
                  title: dialogue.title,
                  preview: dialogue.lines.first.thai,
                  badgeText: dialogue.category.label,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ConversationDetailScreen(
                          dialogue: dialogue,
                          tts: widget.tts,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
