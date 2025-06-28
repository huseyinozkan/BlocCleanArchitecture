/// Route paths
enum RoutePaths {
  splash('/'),
  login('/login'),
  forgotPassword('forgotPassword'),
  forgotPassswordSendOtpCode('forgotPassswordSendOtpCode'),
  home('/home', isAuthRequired: true),
  appSettings('appSettings'),
  updatePassword('updatePassword', isAuthRequired: true),
  admin('admin', isAuthRequired: true),
  ;

  const RoutePaths(this.asRoutePath, {this.isAuthRequired = false});

  final String asRoutePath;
  final bool isAuthRequired;
}
