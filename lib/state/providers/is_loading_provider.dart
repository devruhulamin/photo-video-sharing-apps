import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/image_upload/providers/image_upload_providers.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isImageUploading = ref.watch(imageUploadProvider);

  return authState.isLoading || isImageUploading;
});
