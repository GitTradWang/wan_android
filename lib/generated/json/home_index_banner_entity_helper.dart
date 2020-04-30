import 'package:wanandroidflutter/entity/home_index_banner_entity.dart';

homeIndexBannerEntityFromJson(
    HomeIndexBannerEntity data, Map<String, dynamic> json) {
  if (json['desc'] != null) {
    data.desc = json['desc']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toDouble();
  }
  if (json['imagePath'] != null) {
    data.imagePath = json['imagePath']?.toString();
  }
  if (json['isVisible'] != null) {
    data.isVisible = json['isVisible']?.toDouble();
  }
  if (json['order'] != null) {
    data.order = json['order']?.toDouble();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['type'] != null) {
    data.type = json['type']?.toDouble();
  }
  if (json['url'] != null) {
    data.url = json['url']?.toString();
  }
  return data;
}

Map<String, dynamic> homeIndexBannerEntityToJson(HomeIndexBannerEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['desc'] = entity.desc;
  data['id'] = entity.id;
  data['imagePath'] = entity.imagePath;
  data['isVisible'] = entity.isVisible;
  data['order'] = entity.order;
  data['title'] = entity.title;
  data['type'] = entity.type;
  data['url'] = entity.url;
  return data;
}
