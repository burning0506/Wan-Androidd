
import 'package:json_annotation/json_annotation.dart';

part 'groups.g.dart';

@JsonSerializable()
class Groups {

  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  Groups(this.courseId, this.id, this.name, this.order, this.parentChapterId,
      this.userControlSetTop, this.visible);

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsToJson(this);

}