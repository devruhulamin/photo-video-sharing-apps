import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/post_setting.dart';

class PostSettingsNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {for (final setting in PostSetting.values) setting: true},
          ),
        );

  void setSettng(PostSetting setting, bool value) {
    final existingSetting = state[setting];
    if (existingSetting == null || existingSetting == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
