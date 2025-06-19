import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name:'_id')
  final String? userId;
  final String fullname;
  final String email;
  final String phone;
  final String password;

  const UserApiModel({
    this.userId,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
  });
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      fullname: fullname,
      email: email,
      phone: phone,
      password: password ?? '',
    );
  }

  factory UserApiModel.fromEntity(UserEntity entity) {
    final user = UserApiModel(
      fullname: entity.fullname,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
    );
    return user;
  }

  @override
  List<Object?> get props => [userId, fullname, email, phone, password];
}
