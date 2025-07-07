/// Route paths
enum RoutePaths {
  splash('/'),
  login('/login'),
  forgotPassword('forgotPassword'),
  forgotPassswordSendOtpCode('forgotPassswordSendOtpCode'),
  products('/products', isAuthRequired: true),
  account('/account', isAuthRequired: true),
  adminOperations('adminOperations', isAuthRequired: true),
  adminOrders('adminOrders', isAuthRequired: true),
  pastOrders('pastOrders', isAuthRequired: true),
  addresses('addresses', isAuthRequired: true),
  addressDetail('addressDetail', isAuthRequired: true),
  updatePassword('updatePassword', isAuthRequired: true),
  settings('settings', isAuthRequired: true),
  cart('/cart', isAuthRequired: true),
  order('order', isAuthRequired: true),
  ;

  const RoutePaths(this.asRoutePath, {this.isAuthRequired = false});

  final String asRoutePath;
  final bool isAuthRequired;
}
