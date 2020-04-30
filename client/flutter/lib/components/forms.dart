import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_app/constants.dart';

typedef OptionGroupCallback = void Function(int idx, List<bool> isSelected);

class PickOneOptionGroup extends StatefulWidget {
  final OptionGroupCallback onPressed;
  final List<Map<String, String>> items;
  final List<bool> isSelected;

  const PickOneOptionGroup(
      {@required this.onPressed,
      @required this.items,
      @required this.isSelected})
      : assert(items.length == isSelected.length);

  @override
  _PickOneOptionGroupState createState() => _PickOneOptionGroupState(
      items: items, isSelected: isSelected, onPressed: onPressed);
}

class _PickOneOptionGroupState extends State<PickOneOptionGroup> {
  final OptionGroupCallback onPressed;
  final List<Map<String, String>> items;
  List<bool> isSelected;

  _PickOneOptionGroupState(
      {@required this.onPressed,
      @required this.items,
      @required this.isSelected})
      : assert(items.length == isSelected.length);

  @override
  Widget build(BuildContext context) {
    return OptionGroup(
      items: items,
      onPressed: (idx) {
        setState(() {
          if (isSelected[idx]) {
            isSelected[idx] = false;
          } else {
            for (var i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == idx;
            }
          }
        });
        if (onPressed != null) {
          onPressed(idx, isSelected);
        }
      },
      isSelected: isSelected,
    );
  }
}

class PickOneOrMoreOptionGroup extends StatefulWidget {
  final OptionGroupCallback onPressed;
  final List<Map<String, String>> items;
  final List<bool> isSelected;

  const PickOneOrMoreOptionGroup(
      {@required this.onPressed,
      @required this.items,
      @required this.isSelected})
      : assert(items.length == isSelected.length);

  @override
  _PickOneOrMoreOptionGroupState createState() =>
      _PickOneOrMoreOptionGroupState(
          items: items, isSelected: isSelected, onPressed: onPressed);
}

class _PickOneOrMoreOptionGroupState extends State<PickOneOrMoreOptionGroup> {
  final OptionGroupCallback onPressed;
  final List<Map<String, String>> items;
  List<bool> isSelected;

  _PickOneOrMoreOptionGroupState(
      {@required this.onPressed,
      @required this.items,
      @required this.isSelected})
      : assert(items.length == isSelected.length);

  @override
  Widget build(BuildContext context) {
    return OptionGroup(
      items: items,
      onPressed: (idx) {
        setState(() {
          isSelected[idx] = !isSelected[idx];
          if (isSelected[idx] && items[idx]['noneOfTheAbove'] != null) {
            for (var i = 0; i < idx; i++) {
              isSelected[i] = false;
            }
          }
          if (isSelected[idx] && items[idx]['noneOfTheAbove'] == null) {
            for (var i = idx + 1; i < isSelected.length; i++) {
              if (items[i]['noneOfTheAbove'] != null) {
                isSelected[i] = false;
              }
            }
          }
        });
        if (onPressed != null) {
          onPressed(idx, isSelected);
        }
      },
      isSelected: isSelected,
    );
  }
}

class OptionGroup extends StatelessWidget {
  final void Function(int index) onPressed;
  final List<Map<String, String>> items;
  final List<bool> isSelected;

  const OptionGroup(
      {@required this.onPressed,
      @required this.items,
      @required this.isSelected})
      : assert(items.length == isSelected.length);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: items.asMap().entries.map((entry) {
      return ToggleOption(
        title: entry.value["title"],
        icon: entry.value["icon"],
        color: CupertinoColors.white,
        value: isSelected[entry.key],
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
    @required this.icon,
    @required this.color,
    this.value,
    this.onPressed,
  });

  final String icon;
  final String title;
  final Color color;
  final bool value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: value ? 3 : 1.5,
              color: value
                  ? Constants.primaryColor
                  : Color.fromARGB(
                      64,
                      92,
                      97,
                      100,
                    )),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                child: Text(
                  icon,
                  style: TextStyle(fontSize: 40),
                ),
                padding: EdgeInsets.zero),
            SizedBox(
              width: 12,
            ),
            Padding(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.zero),
          ],
        ),
      ),
    );
  }
}
