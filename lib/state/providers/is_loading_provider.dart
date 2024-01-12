import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/comment/providers/delete_comment_provider.dart';
import 'package:instagram_clone/state/comment/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/providers/image_upload_providers.dart';
import 'package:instagram_clone/state/post/providers/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authLoading = ref.watch(authStateProvider).isLoading;
  final isImageUploading = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  return authLoading ||
      isImageUploading ||
      isSendingComment ||
      isDeletingPost ||
      isDeletingComment;
});
