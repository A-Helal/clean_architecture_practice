import 'package:clean_arch_prac/core/errors/failure.dart';
import 'package:clean_arch_prac/core/params/user_params.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/user_entity.dart';
import 'package:clean_arch_prac/feature/user/domain/repo/user_repo.dart';
import 'package:dartz/dartz.dart';

class GetUser {
  final UserRepo userRepo;

  GetUser({required this.userRepo});

  Future<Either<Failure, UserEntity>> call({required UserParams params}) {
    return userRepo.getUser(params: params);
  }
}
