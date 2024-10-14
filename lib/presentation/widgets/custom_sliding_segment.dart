import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/theme/app_theme.dart';
import 'package:pokedex/domain/entities/select_item.dart';

class CustomSlidingSegment extends StatelessWidget {
  const CustomSlidingSegment({
    super.key,
    required this.items,
    required this.groupValue,
    required this.onValueChanged,
  });

  final List<SelectItem> items;
  final dynamic groupValue;
  final ValueChanged onValueChanged;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
        groupValue: groupValue,
        children: {
          for (var item in items)
            item.code: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                item.value,
                style: theme.normalText.copyWith(
                    color: groupValue == item.code
                        ? Colors.black
                        : null),
              ),
            ),
        },
        thumbColor: theme.primary,
        onValueChanged: (newSelection) {
          onValueChanged(newSelection);
        },
      ),
    );
  }
}