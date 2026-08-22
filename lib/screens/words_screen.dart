import 'package:flutter/material.dart';

import '../data/words_data.dart';
import '../models/word.dart';
import '../services/tts_service.dart';
import '../widgets/class_filter_chips.dart';
import '../widgets/word_list_tile.dart';
import 'word_detail_screen.dart';

final _wordFilterLabels = [
  '전체',
  ...WordCategory.values.map((c) => c.label),
];

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key, required this.tts});

  final TtsService tts;

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  int _filterIndex = 0;

  List<Word> get _filteredWords {
    if (_filterIndex == 0) return words;
    final targetCategory = WordCategory.values[_filterIndex - 1];
    return words.where((w) => w.category == targetCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('단어')),
      body: Column(
        children: [
          ClassFilterChips(
            labels: _wordFilterLabels,
            selectedIndex: _filterIndex,
            onSelected: (i) => setState(() => _filterIndex = i),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              itemCount: _filteredWords.length,
              itemBuilder: (context, index) {
                final word = _filteredWords[index];
                return WordListTile(
                  thai: word.thai,
                  subtitle: '${word.romanization} · ${word.meaningKorean}',
                  badgeText: word.category.label,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            WordDetailScreen(word: word, tts: widget.tts),
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
