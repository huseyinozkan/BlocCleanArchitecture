import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class DateTimeButton extends StatelessWidget {
  const DateTimeButton({
    this.title,
    this.value,
    this.onPressed,
    super.key,
  });

  final String? title;
  final String? value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotNullAndNotEmpty) CoreText.labelSmall(title),
        if (title.isNotNullAndNotEmpty) verticalBox4,
        CoreButton(
          onPressed: onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.onSurface, width: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(child: CoreText.bodyMedium(value ?? '')),
                  Icon(Icons.calendar_today, color: context.colorScheme.primary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
