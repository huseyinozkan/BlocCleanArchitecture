import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Spacer(),
            Assets.images.somethingWentWrong.image(width: context.width * 0.4),
            const CoreRelativeHeight(0.05),
            CoreText.headlineSmall(
              LocalizationKey.somethingWentWrongDescription.tr(context),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
