part of '../../../../models/models.dart';

class VideosModel extends Equatable {
  final String key;
  final String name;
  final String type;
  VideosModel({this.key, this.name, this.type});
  @override
  List<Object> get props => [key,name,type];
}
