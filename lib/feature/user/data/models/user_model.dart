import 'package:clean_arch_prac/core/database/API/end_points.dart';
import 'package:clean_arch_prac/feature/user/data/models/sub_models/address_model.dart';
import 'package:clean_arch_prac/feature/user/data/models/sub_models/company_model.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  int id;
  final String username;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required this.username,
    required this.website,
    required this.company,
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKey.id],
      username: json[ApiKey.username],
      website: json[ApiKey.website],
      name: json[ApiKey.name],
      phone: json[ApiKey.phone],
      email: json[ApiKey.email],
      company: CompanyModel.fromJson(json[ApiKey.company]),
      address: AddressModel.fromJson(json[ApiKey.address]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.username: username,
      ApiKey.website: website,
      ApiKey.name: name,
      ApiKey.phone: phone,
      ApiKey.email: email,
      ApiKey.company: company.toJson(),
      ApiKey.address: (address as AddressModel).toJson(),
    };
  }
}
