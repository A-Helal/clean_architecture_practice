import 'package:bloc/bloc.dart';
import 'package:clean_arch_prac/core/params/user_params.dart';
import 'package:clean_arch_prac/feature/user/data/repo/user_repo_impl.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/user_entity.dart';
import 'package:clean_arch_prac/feature/user/domain/usecases/get_user.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  eitherFailureOrUser(int id) async {
    emit(GetUserLoading());
    final failureOrUser = await GetUser(
      userRepo: UserRepoImpl(),
    ).call(params: UserParams(id: id.toString()));

    failureOrUser.fold(
      (failure) => emit(GetUserFailure(errMessage: failure.errMessage)),
      (user) => emit(GetUserSuccessfully(user: user)),
    );
  }
}
