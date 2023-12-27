import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/constants/loading/loading_controller.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? _controller;

  void show({required BuildContext context, String text = Strings.loading}) {
    if (_controller?.updateLoadingScreem(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(context: context, text: text);
    }
  }

  void close() {
    _controller?.closeLoadingScreen;
    _controller = null;
  }

  LoadingScreenController? showOverlay(
      {required BuildContext context, required String text}) {
    final state = Overlay.of(context);
    final textController = StreamController<String>();
    textController.add(text);
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<String>(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingScreenController(
      closeLoadingScreen: () {
        textController.close();
        overlay.remove();
        return true;
      },
      updateLoadingScreem: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
