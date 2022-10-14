import 'package:flutter/material.dart';

import '../../models/preferences_model.dart';

/// Sort group for articles' sort options.
class SortMethodGroup extends StatefulWidget {
  const SortMethodGroup({
    required this.selectedItem,
    required this.onOptionTap,
    super.key,
  });

  final ValueChanged<SortMethod> onOptionTap;
  final SortMethod selectedItem;

  @override
  State<SortMethodGroup> createState() => _SortMethodGroupState();
}

class _SortMethodGroupState extends State<SortMethodGroup> {
  final Map<String, SortMethod> _choicesMap = {
    "Random": SortMethod.random,
    "Ascending": SortMethod.asc,
    "Descending": SortMethod.desc
  };
  SortMethod defaultChoice = SortMethod.random;
  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        children: List.generate(3, (index) {
          return ChoiceChip(
            labelPadding: const EdgeInsets.all(2.0),
            label: Text(
              _choicesMap.keys.elementAt(index),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
            selected: defaultChoice == _choicesMap.values.elementAt(index),
            selectedColor: Colors.orangeAccent, //TODO: Change to orange
            onSelected: (value) {
              setState(() {
                defaultChoice = value
                    ? _choicesMap.values.elementAt(index)
                    : defaultChoice; //TODO: BUBBLE THIS UP TO onOptionTap !!!!
              });
            },
            // backgroundColor: color,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          );
        }),
      );
}
