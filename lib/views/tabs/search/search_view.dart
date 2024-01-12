import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/views/components/search/search_grid_view.dart';
import 'package:instagram_clone/views/constants/view_strings.dart';
import 'package:instagram_clone/views/extensions/dissmiss_keyboard.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final searchTerm = useState('');

    useEffect(() {
      controller.addListener(() {
        searchTerm.value = controller.text;
      });
      return () {};
    }, [controller]);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                hintText: ViewStrings.enterYourSearchTermHere,
                suffix: IconButton(
                    onPressed: () {
                      controller.clear();
                      dissMissKeyboard();
                    },
                    icon: const Icon(Icons.clear))),
          ),
        ),
        Expanded(
            child: SearchGridView(
          searchTerm: searchTerm.value,
        ))
      ],
    );
  }
}
