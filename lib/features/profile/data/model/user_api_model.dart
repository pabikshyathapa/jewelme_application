import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/user_entity.dart';  // import your entity

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id') 
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? filepath;

  const UserApiModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.filepath,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  /// Converts API model to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id ?? '',
      name: name ?? '',
      email: email ?? '',
      phone: phone ?? '',
      filepath: filepath,
    );
  }

  /// Converts domain entity back to API model
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      filepath: entity.filepath,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, filepath];
}
