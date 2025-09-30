import 'package:clean_arch_prac/core/connection/network_info.dart';
import 'package:clean_arch_prac/core/errors/exceptions.dart';
import 'package:clean_arch_prac/core/errors/failure.dart';
import 'package:clean_arch_prac/core/params/user_params.dart';
import 'package:clean_arch_prac/feature/user/data/data_source/user_local_data_source.dart';
import 'package:clean_arch_prac/feature/user/data/data_source/user_remote_data_source.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/user_entity.dart';
import 'package:clean_arch_prac/feature/user/domain/repo/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl extends UserRepo {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  UserRepoImpl({required this.networkInfo, required this.userRemoteDataSource, required this.userLocalDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUser({
    required UserParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUser = await userRemoteDataSource.getUser(params);
        userLocalDataSource.cashUser(remoteUser);
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final localUser = await userLocalDataSource.getLastUser();
        return Right(localUser);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }
  }
}
