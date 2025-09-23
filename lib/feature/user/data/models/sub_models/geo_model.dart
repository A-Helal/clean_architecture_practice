import 'package:clean_arch_prac/core/database/API/end_points.dart';
import 'package:clean_arch_prac/feature/user/domain/entites/sub_entities/geo_entity.dart';

class GeoModel extends GeoEntity{
  GeoModel({required super.lat, required super.lng});

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(lat: json[ApiKey.lat], lng: json[ApiKey.lng]);
  }

  Map<String, dynamic> toJson() {
    return {ApiKey.lat: lat, ApiKey.lng: lng};
  }
}
