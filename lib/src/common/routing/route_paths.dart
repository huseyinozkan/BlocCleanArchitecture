/// Route paths
enum RoutePaths {
  splash('/'),
  login('/login'),
  forgotPassword('forgotPassword'),
  forgotPassswordSendOtpCode('forgotPassswordSendOtpCode'),
  settings('settings', isAuthRequired: true),
  updatePassword('updatePassword', isAuthRequired: true),
  adminOperations('adminOperations', isAuthRequired: true),
  products('/products', isAuthRequired: true),
  account('/account', isAuthRequired: true),
  addresses('addresses', isAuthRequired: true),
  addressDetail('addressDetail', isAuthRequired: true),
  pastOrders('pastOrders', isAuthRequired: true),
  basket('/basket', isAuthRequired: true),
  order('/order', isAuthRequired: true),
  ;

  const RoutePaths(this.asRoutePath, {this.isAuthRequired = false});

  final String asRoutePath;
  final bool isAuthRequired;
}
