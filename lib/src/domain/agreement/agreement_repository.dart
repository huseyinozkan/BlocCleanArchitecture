import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/agreement_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/response/agreement_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAgreementRepository {
  Future<BaseResponse<List<AgreementDto>>> currentAgreements();
}

@LazySingleton(as: IAgreementRepository)
final class AgreementRepository implements IAgreementRepository {
  const AgreementRepository(this._agreementRemoteDS);

  final IAgreementRemoteDS _agreementRemoteDS;

  @override
  Future<BaseResponse<List<AgreementDto>>> currentAgreements() => _agreementRemoteDS.currentAgreements();
}
