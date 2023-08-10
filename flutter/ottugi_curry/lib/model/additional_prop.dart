import 'package:json_annotation/json_annotation.dart';

part 'additional_prop.g.dart';

@JsonSerializable()
class AdditionalProp {
  double? additionalProp;

  AdditionalProp({
    this.additionalProp,
  });

  factory AdditionalProp.fromJson(Map<String, dynamic> json) => _$AdditionalPropFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalPropToJson(this);
}
