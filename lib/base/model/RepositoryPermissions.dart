import 'package:json_annotation/json_annotation.dart';

part 'RepositoryPermissions.g.dart';

@JsonSerializable()
class RepositoryPermissions {
  bool admin;
  bool push;
  bool pull;

  RepositoryPermissions(
    this.admin,
    this.push,
    this.pull,
  );
}
