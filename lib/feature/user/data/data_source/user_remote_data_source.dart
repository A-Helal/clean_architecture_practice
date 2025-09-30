import 'package:clean_arch_prac/core/database/API/API_consumer.dart';
import 'package:clean_arch_prac/core/database/API/end_points.dart';
import 'package:clean_arch_prac/core/params/user_params.dart';
import 'package:clean_arch_prac/feature/user/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiConsumer apiConsumer;

  UserRemoteDataSource({required this.apiConsumer});

  Future<UserModel> getUser(UserParams params) async {
    final response = await apiConsumer.get('${EndPoints.user}/${params.id}');
    final userModel = UserModel.fromJson(response);
    return userModel;
  }
}
