import 'package:bloc_clean_architecture/src/common/widgets/others/adaptive_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class BasicWebContent extends StatefulWidget {
  const BasicWebContent({required this.url, super.key});

  final String url;

  @override
  State<BasicWebContent> createState() => _BasicWebContentState();
}

class _BasicWebContentState extends State<BasicWebContent> {
  late final WebViewController _controller;

  bool onPageFinished = false;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('onProgress : $progress');
          },
          onPageStarted: (String url) {
            debugPrint('onPageStarted');
          },
          onPageFinished: (String url) {
            debugPrint('onPageFinished');
            setState(() => onPageFinished = true);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error;
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('onNavigationRequest');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('onHttpError: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('onUrlChange');
          },
          onHttpAuthRequest: (httpAuthRequest) {
            debugPrint('http auth request: $httpAuthRequest');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      const Factory(EagerGestureRecognizer.new),
    };

    final key = UniqueKey();
    return onPageFinished
        ? WebViewWidget(
            key: key,
            gestureRecognizers: gestureRecognizers,
            controller: _controller,
          )
        : const AdaptiveIndicator();
  }
}
