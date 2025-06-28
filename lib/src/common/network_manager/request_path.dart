import 'package:flutter_core/flutter_core.dart';

const String _basePath = '/ecommerce/api/v1';
const String _auth = '$_basePath/auth';
const String _culture = '$_basePath/culture';
const String _resource = '$_basePath/resource';
const String _agreement = '$_basePath/agreement';
const String _address = '$_basePath/address';
const String _cartItem = '$_basePath/cart-item';
const String _category = '$_basePath/category';
const String _file = '$_basePath/file';
const String _order = '$_basePath/order';
const String _payment = '$_basePath/payment';
const String _product = '$_basePath/product';

enum RequestPath implements BaseRequestPath {
  login('$_auth/login'),
  refreshToken('$_auth/refresh-token'),
  sendOtpCode('$_auth/send-otp-code'),
  register('$_auth/register'),
  forgotPassword('$_auth/forgot-password'),
  updatePassword('$_auth/update-password'),
  approveAgreements('$_auth/approve-agreements'),
  culture(_culture),
  resource(_resource),
  currentAgreements('$_agreement/current'),
  address(_address),
  cartItem(_cartItem),
  cartItemDeleteAll('$_cartItem/delete-all'),
  category(_category),
  file(_file),
  fileByte('$_file/byte'),
  order(_order),
  orderAdmin('$_order/admin'),
  orderAdminByOrderStatus('$_order/admin/by-order-status'),
  orderUpdateOrderStatus('$_order/update-order-status'),
  paymentUpdatePaymentStatus('$_payment/update-payment-status'),
  product(_product),
  productByCategoryId('$_product/by-category-id'),
  ;

  const RequestPath(this.value);

  final String value;

  @override
  String get asString => value;
}
