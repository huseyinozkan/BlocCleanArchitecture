import 'package:bloc_clean_architecture/src/data/model/request/agreement_id_and_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'approve_agreement_request.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
final class ApproveAgreementRequest with BaseModel<ApproveAgreementRequest> {
  const ApproveAgreementRequest({
    this.agreements,
  });

  factory ApproveAgreementRequest.fromJson(Map<String, dynamic> json) => const ApproveAgreementRequest().fromJson(json);

  final List<AgreementIdAndType>? agreements;

  @override
  Map<String, dynamic> toJson() => _$ApproveAgreementRequestToJson(this);

  @override
  ApproveAgreementRequest fromJson(Map<String, Object?> json) => _$ApproveAgreementRequestFromJson(json);
}
