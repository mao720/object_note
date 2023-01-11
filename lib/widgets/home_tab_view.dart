import 'package:flutter/material.dart';

class HomeTabView extends StatefulWidget {
  final int initialIndex;

  const HomeTabView({super.key, this.initialIndex = 0});

  @override
  State<StatefulWidget> createState() {
    return _HomeTabViewState();
  }
}

class _HomeTabViewState extends State<HomeTabView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  Widget _buildItem(IconData icon, bool isSelected, void Function() onPressed) {
    var colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      iconSize: 30,
      hoverColor: Colors.transparent,
      icon: Icon(
        icon,
        color: colorScheme.primary.withOpacity(isSelected ? 1 : 0.6),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(Icons.home, true, () {}),
          _buildItem(Icons.man, false, () {}),
        ],
      ),
    );
  }
}
