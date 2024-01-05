import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/post/typedefs/post_id.dart';

@immutable
class RequestForPostAndComment {
  final PostId postId;
  final DateSorting dateSorting;
  final bool sortBycreatedAt;
  final int? limit;

  const RequestForPostAndComment(
      {required this.postId,
      this.dateSorting = DateSorting.newestOnTop,
      this.sortBycreatedAt = true,
      this.limit});

  @override
  operator ==(covariant RequestForPostAndComment other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          postId == other.postId &&
          dateSorting == other.dateSorting &&
          sortBycreatedAt == other.sortBycreatedAt &&
          limit == other.limit);

  @override
  int get hashCode => Object.hashAll(
      [runtimeType, postId, dateSorting, sortBycreatedAt, limit]);
}
