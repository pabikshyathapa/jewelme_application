import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

class UserHiveModel extends Equatable{
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullname;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String password;

UserHiveModel({
    String? userId,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
   
  }) : userId = userId ?? const Uuid().v4();

  const UserHiveModel.initial()
  : userId='',
  fullname='',
  email='',
  phone='',
  password=''

}