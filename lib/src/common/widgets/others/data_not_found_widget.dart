import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class DataNotFoundWidget extends StatelessWidget {
  const DataNotFoundWidget({
    super.key,
    this.description,
  });

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24,
        children: [
          Assets.images.dataNotFound.image(width: context.width * 0.5),
          Row(
            children: [
              Expanded(child: CoreText.titleLarge(description ?? LocalizationKey.dataNotFound.tr(context), textAlign: TextAlign.center)),
            ],
          ),
        ],
      ),
    );
  }
}
