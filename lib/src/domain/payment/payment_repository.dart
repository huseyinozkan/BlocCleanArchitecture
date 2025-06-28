import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/payment_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_payment_status_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/payment_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IPaymentRepository {
  Future<BaseResponse<PaymentDto>> updatePaymentStatus(UpdatePaymentStatusRequest request);
}

@LazySingleton(as: IPaymentRepository)
final class PaymentRepository implements IPaymentRepository {
  const PaymentRepository(this._paymentRemoteDS);

  final IPaymentRemoteDS _paymentRemoteDS;

  @override
  Future<BaseResponse<PaymentDto>> updatePaymentStatus(UpdatePaymentStatusRequest request) => _paymentRemoteDS.updatePaymentStatus(request);
}
