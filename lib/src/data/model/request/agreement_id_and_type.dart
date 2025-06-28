import 'package:bloc_clean_architecture/src/data/model/enums/agreement_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement_id_and_type.g.dart';

@immutable
@JsonSerializable()
final class AgreementIdAndType with BaseModel<AgreementIdAndType> {
  const AgreementIdAndType({
    this.id,
    this.type,
  });

  factory AgreementIdAndType.fromJson(Map<String, dynamic> json) => const AgreementIdAndType().fromJson(json);

  final int? id;
  final AgreementType? type;

  @override
  Map<String, dynamic> toJson() => _$AgreementIdAndTypeToJson(this);

  @override
  AgreementIdAndType fromJson(Map<String, Object?> json) => _$AgreementIdAndTypeFromJson(json);
}
