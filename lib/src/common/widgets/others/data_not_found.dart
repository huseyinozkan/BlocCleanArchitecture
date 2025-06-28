import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePaddingHorizontal,
        child: SizedBox(
          height: context.height * 0.7,
          child: Column(
            children: [
              Assets.images.dataNotFound.image(width: context.width * 0.3, color: context.colorScheme.onSurface),
              CoreText.headlineSmall(message ?? LocalizationKey.dataNotFoundDescription.tr(context), textAlign: TextAlign.center),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
