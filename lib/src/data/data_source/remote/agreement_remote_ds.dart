import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/data/model/response/agreement_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAgreementRemoteDS {
  Future<BaseResponse<List<AgreementDto>>> currentAgreements();
}

@LazySingleton(as: IAgreementRemoteDS)
final class AgreementRemoteDS implements IAgreementRemoteDS {
  const AgreementRemoteDS(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<AgreementDto>>> currentAgreements() {
    return _networkManager.request<List<AgreementDto>, AgreementDto>(
      path: RequestPath.currentAgreements,
      type: RequestType.get,
      responseEntityModel: const AgreementDto(),
    );
  }
}
