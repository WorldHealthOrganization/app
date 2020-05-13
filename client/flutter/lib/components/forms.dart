import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/components/themed_text.dart';
import 'package:who_app/constants.dart';

typedef OptionGroupCallback = void Function(int idx, List<OptionItem> items);

class OptionItem {
  final String title;
  bool selected;

  OptionItem({@required this.title, this.selected = false});
}

class MultiSelectOptionItem extends OptionItem {
  final bool noneOfTheAbove;

  MultiSelectOptionItem(
      {@required String title,
      bool selected = false,
      this.noneOfTheAbove = false})
      : super(title: title, selected: selected);
}

class PickOneOptionGroup extends StatefulWidget {
  final OptionGroupCallback onPressed;
  final List<OptionItem> items;

  const PickOneOptionGroup({
    @required this.onPressed,
    @required this.items,
  });

  @override
  _PickOneOptionGroupState createState() =>
      _PickOneOptionGroupState(items: items, onPressed: onPressed);
}

class _PickOneOptionGroupState extends State<PickOneOptionGroup> {
  final OptionGroupCallback onPressed;
  final List<OptionItem> items;

  _PickOneOptionGroupState({@required this.onPressed, @required this.items});

  @override
  Widget build(BuildContext context) {
    return OptionGroup(
      items: items,
      onPressed: (idx) {
        setState(() {
          if (items[idx].selected) {
            items[idx].selected = false;
          } else {
            for (var i = 0; i < items.length; i++) {
              items[i].selected = i == idx;
            }
          }
        });
        if (onPressed != null) {
          onPressed(idx, items);
        }
      },
    );
  }
}

class PickOneOrMoreOptionGroup extends StatefulWidget {
  final OptionGroupCallback onPressed;
  final List<MultiSelectOptionItem> items;

  const PickOneOrMoreOptionGroup({
    @required this.onPressed,
    @required this.items,
  });

  @override
  _PickOneOrMoreOptionGroupState createState() =>
      _PickOneOrMoreOptionGroupState(items: items, onPressed: onPressed);
}

class _PickOneOrMoreOptionGroupState extends State<PickOneOrMoreOptionGroup> {
  final OptionGroupCallback onPressed;
  final List<MultiSelectOptionItem> items;

  _PickOneOrMoreOptionGroupState({
    @required this.onPressed,
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return OptionGroup(
      items: items,
      onPressed: (idx) {
        setState(() {
          items[idx].selected = !items[idx].selected;
          if (items[idx].selected) {
            if (items[idx].noneOfTheAbove) {
              for (var i = 0; i < idx; i++) {
                items[i].selected = false;
              }
            } else {
              for (var i = idx + 1; i < items.length; i++) {
                if (items[i].noneOfTheAbove) {
                  items[i].selected = false;
                }
              }
            }
          }
        });
        if (onPressed != null) {
          onPressed(idx, items);
        }
      },
    );
  }
}

class OptionGroup<T extends OptionItem> extends StatelessWidget {
  final void Function(int index) onPressed;
  final List<T> items;

  const OptionGroup({
    @required this.onPressed,
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: items.asMap().entries.map((entry) {
      return ToggleOption(
        title: entry.value.title,
        color: CupertinoColors.white,
        value: entry.value.selected,
        onPressed: () {
          onPressed(entry.key);
        },
      );
    }).toList());
  }
}

class ToggleOption extends StatelessWidget {
  const ToggleOption({
    @required this.title,
    @required this.color,
    this.value,
    this.onPressed,
  });

  final String title;
  final Color color;
  final bool value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.5,
            color: value
                ? Constants.whoBackgroundBlueColor
                : Constants.itemBorderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: ThemedText(
                title,
                variant: TypographyVariant.h4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
