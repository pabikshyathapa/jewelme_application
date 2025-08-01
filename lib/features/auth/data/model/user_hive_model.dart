import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jewelme_application/app/constant/hive_table_constant.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';
@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable{
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String password;

UserHiveModel({
    String? userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
   
  }) : userId = userId ?? const Uuid().v4();

  const UserHiveModel.initial()
  : userId='',
  name='',
  email='',
  phone='',
  password='';

  factory UserHiveModel.fromEntity(UserEntity entity){
    return UserHiveModel(
    userId: entity.userId,
    name:entity.name,
    email: entity.email,
    phone: entity.phone,
    password: entity.password,
       );
  }

  UserEntity toEntity(){
    return UserEntity(
    userId: userId,
    name: name,
    email: email,
    phone: phone,
    password: password
       );
  }
  @override
  List<Object?> get props => [
      userId,
      name,
      email,
      phone,
      password,
  ];
  }