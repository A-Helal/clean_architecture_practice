import 'package:clean_arch_prac/core/errors/failure.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo{
  Future<Either<Failure,UserEntity>>getUser();
}