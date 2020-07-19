import 'package:flutter_demo/base/model/PushEventCommit.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Issue.dart';
import 'IssueEvent.dart';
import 'Release.dart';

part 'EventPayload.g.dart';

@JsonSerializable()
class EventPayload {
  @JsonKey(name: "push_id")
  int pushId;
  int size;
  @JsonKey(name: "distinct_size")
  int distinctSize;
  String ref;
  String head;
  String before;
  List<PushEventCommit> commits;

  String action;
  @JsonKey(name: "ref_type")
  String refType;
  @JsonKey(name: "master_branch")
  String masterBranch;
  String description;
  @JsonKey(name: "pusher_type")
  String pusherType;

  Release release;
  Issue issue;
  IssueEvent comment;

  EventPayload();
}
