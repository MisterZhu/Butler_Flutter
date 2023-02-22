import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sc_uikit/sc_uikit.dart';

/// 键盘

class SCKeyboard {
  static KeyboardActionsConfig keyboardConfig(
      {required FocusNode node, required BuildContext context}) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: SCColors.color_F2F3F5,
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: node,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                  child: const Text(
                    "完成",
                    style: TextStyle(color: SCColors.color_4285F4),
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }
}
