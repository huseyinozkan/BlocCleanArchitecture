import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/request/update_payment_status_request.dart';
import 'package:bloc_clean_architecture/src/data/model/response/payment_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IPaymentRemoteDS {
  Future<BaseResponse<PaymentDto>> updatePaymentStatus(UpdatePaymentStatusRequest request);
}

@LazySingleton(as: IPaymentRemoteDS)
final class PaymentRemoteDS implements IPaymentRemoteDS {
  const PaymentRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<PaymentDto>> updatePaymentStatus(UpdatePaymentStatusRequest request) => _networkManager.request<PaymentDto, PaymentDto>(
        path: RequestPath.paymentUpdatePaymentStatus,
        type: RequestType.put,
        data: request,
        responseEntityModel: const PaymentDto(),
      );
}
