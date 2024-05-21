import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maids_task/core/constants/color_constants.dart';
import 'package:maids_task/core/extentions/widget_extensions.dart';
import 'package:maids_task/features/user/domain/entities/user_entity.dart';

class UserCredentialCard extends StatelessWidget {
  const UserCredentialCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Username:',
                      style: TextStyle(fontSize: 16, color: textHint),
                    ).padding(right: 10),
                    Text(
                      user.username,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                      text: user.username,
                    ));
                  },
                  icon: const Icon(Icons.copy),
                  color: textHint,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Password:',
                      style: TextStyle(fontSize: 16, color: textHint),
                    ).padding(right: 10),
                    Text(
                      user.password,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                      text: user.password,
                    ));
                  },
                  icon: const Icon(Icons.copy, color: textHint),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
