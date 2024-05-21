import 'package:flutter/material.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_primary_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_field.dart';


class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            BlueprintTextField(
              controller: controller,
              hintText: 'Add New Task',
              label: 'Add New Task',
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // cancel button
                BlueprintTextButton(title: "Cancel", onPressed: onCancel),

                const SizedBox(width: 8),

                // save button
                BlueprintPrimaryButton(title: "Save", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
