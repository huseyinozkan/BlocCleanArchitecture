/// Route paths
enum RoutePaths {
  splash('/'),
  login('/login'),
  forgotPassword('forgotPassword'),
  forgotPassswordSendOtpCode('forgotPassswordSendOtpCode'),
  settings('settings', isAuthRequired: true),
  updatePassword('updatePassword', isAuthRequired: true),
  admin('admin', isAuthRequired: true),
  products('/products', isAuthRequired: true),
  account('/account', isAuthRequired: true),
  basket('/basket', isAuthRequired: true),
  ;

  const RoutePaths(this.asRoutePath, {this.isAuthRequired = false});

  final String asRoutePath;
  final bool isAuthRequired;
}
