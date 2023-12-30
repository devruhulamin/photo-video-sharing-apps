import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogOutDialog extends AlertDialogModel<bool> {
  const LogOutDialog()
      : super(
            title: Strings.logout,
            message: Strings.areYouSureWantToLogoutThis,
            buttons: const {Strings.canel: false, Strings.logout: true});
}
