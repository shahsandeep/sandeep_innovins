import 'package:flutter/material.dart';
import 'package:innovins_task/core/theme/app_pallete.dart';

class SideMenuTileWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SideMenuTileWidget({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppPallete.purple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        onTap: onTap,
        leading: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }
}
