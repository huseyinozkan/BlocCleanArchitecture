import 'package:bloc_clean_architecture/src/data/model/response/localization_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localization_state.g.dart';

@immutable
@JsonSerializable()
final class LocalizationState extends Equatable {
  const LocalizationState({this.localization});

  factory LocalizationState.fromJson(Map<String, dynamic> json) => _$LocalizationStateFromJson(json);

  final LocalizationDto? localization;

  @override
  List<Object?> get props => [localization];

  LocalizationState copyWith({LocalizationDto? localization}) {
    return LocalizationState(
      localization: localization ?? this.localization,
    );
  }

  Map<String, dynamic> toJson() => _$LocalizationStateToJson(this);
}
