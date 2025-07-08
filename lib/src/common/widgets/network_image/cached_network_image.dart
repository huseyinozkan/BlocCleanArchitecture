import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class MyCachedNetworkImage extends StatelessWidget {
  const MyCachedNetworkImage({required this.imageId, super.key, this.width, this.height, this.fit, this.placeholder, this.errorWidget, this.cacheKey});

  final int? imageId;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final String? cacheKey;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: cacheKey,
      imageUrl: '${AppConstants.networkConstants.baseUrl}${RequestPath.fileByte.value}/$imageId',
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: placeholder ?? (context, url) => const Center(child: CircularProgressIndicator.adaptive()),
      httpHeaders: httpHeaders,
      errorWidget: errorWidget ??
          (context, url, error) => Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(color: context.colorScheme.surfaceContainer),
                child: Icon(Icons.image_not_supported, color: context.colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
    );
  }

  Map<String, String> get httpHeaders {
    final authRepository = getIt<IAuthRepository>();
    final token = authRepository.getUserCredentials()?.accessToken;
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
