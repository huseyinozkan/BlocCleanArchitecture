// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizationState _$LocalizationStateFromJson(Map<String, dynamic> json) =>
    LocalizationState(
      localization: json['localization'] == null
          ? null
          : LocalizationDto.fromJson(
              json['localization'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocalizationStateToJson(LocalizationState instance) =>
    <String, dynamic>{
      'localization': instance.localization,
    };
