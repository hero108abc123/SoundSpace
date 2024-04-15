import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/auth/domain/entities/email.dart';
part 'email_model.g.dart';

@JsonSerializable()
class EmailModel extends Email {
  EmailModel({
    required super.email,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return _$EmailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmailModelToJson(this);
}
