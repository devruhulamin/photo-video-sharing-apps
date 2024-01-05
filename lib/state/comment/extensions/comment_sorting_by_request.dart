import 'package:instagram_clone/enums/date_sorting.dart';
import 'package:instagram_clone/state/comment/models/comment_mode.dart';
import 'package:instagram_clone/state/comment/models/post_comment_request.dart';

extension CommentSortingByRequest on Iterable<CommentModel> {
  Iterable<CommentModel> applySorting(RequestForPostAndComment request) {
    if (request.sortBycreatedAt) {
      final sortedComment = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSorting.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);
              case DateSorting.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return sortedComment;
    } else {
      return this;
    }
  }
}
