import 'package:flutter/material.dart';

import 'language_selector_list_item.dart';

class LanguageSelectorList extends StatelessWidget {
  LanguageSelectorList({
    required this.languageNames,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  final List<String> languageNames;
  final int selectedIndex;
  final void Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: languageNames.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return LanguageSelectorListItem(
          languageName: languageNames[index],
          selected: index == selectedIndex,
          onTap: () => onIndexChanged(index),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black12,
          thickness: 0.5,
          height: 0,
        );
      },
    );
  }
}
