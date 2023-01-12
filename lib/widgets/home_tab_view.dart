import 'package:flutter/material.dart';

class HomeTabView extends StatelessWidget {
  final int currentIndex;
  final List<IconData> tabItems;
  final void Function(int index)? onTap;

  const HomeTabView({
    super.key,
    this.currentIndex = 0,
    required this.tabItems,
    this.onTap,
  });

  Widget _buildItem(BuildContext context, IconData icon, bool isSelected,
      void Function() onPressed) {
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
        children: tabItems
            .asMap()
            .entries
            .map((entry) => _buildItem(
                  context,
                  entry.value,
                  entry.key == currentIndex,
                  () => onTap?.call(entry.key),
                ))
            .toList(),
      ),
    );
  }
}
