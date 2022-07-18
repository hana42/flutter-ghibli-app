import 'package:flutter/material.dart';

class VerticalIconButton extends StatelessWidget {
  final IconData icon;
  final String? title;
  final Color? color;
  final void Function() onTap;

  const VerticalIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: title != null
          ? Column(
              children: [
                Icon(icon, color: color ?? Colors.white),
                const SizedBox(height: 2.0),
                Text(
                  title.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
          : Icon(icon, color: color ?? Colors.white),
    );
  }
}
