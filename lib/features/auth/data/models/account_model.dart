import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/auth/domain/entities/account.dart';
part 'account_model.g.dart';

@JsonSerializable()
class AccountModel extends Account {
  AccountModel({
    required super.email,
    required super.password,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return _$AccountModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
