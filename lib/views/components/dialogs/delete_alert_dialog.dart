import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  DeleteDialog({required String titleOfObjectToDelete})
      : super(
            title: '${Strings.delete} $titleOfObjectToDelete',
            message:
                '${Strings.areYourSureWantToDeleteThis} $titleOfObjectToDelete',
            buttons: {
              Strings.canel: false,
              Strings.delete: true,
            });
}
