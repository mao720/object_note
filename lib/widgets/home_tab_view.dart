import 'package:flutter/material.dart';

import '../core/config.dart';

class HomeTabView extends StatefulWidget {
  final int currentIndex;
  final void Function(int index)? onTap;

  const HomeTabView({super.key, this.currentIndex = 0, this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _HomeTabViewState();
  }
}

class _HomeTabViewState extends State<HomeTabView> {
  Widget _buildItem(IconData icon, bool isSelected, void Function() onPressed) {
    var colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      iconSize: 30,
      hoverColor: Colors.transparent,
      icon: Icon(icon,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSurface.withOpacity(0.6)),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: AppConfig.bottomTabItems
            .asMap()
            .entries
            .map((entry) => _buildItem(
                  entry.value,
                  entry.key == widget.currentIndex,
                  () => widget.onTap?.call(entry.key),
                ))
            .toList(),
      ),
    );
  }
}
