import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:linring_front_flutter/models/user_model.dart';

class CustomProfileModal extends StatelessWidget {
  const CustomProfileModal({
    super.key,
    required this.tag,
  });

  final Tagset tag;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(),
            Column(
              children: [
                Text(""),
                Text(""),
              ],
            )
          ],
        ),
        Text(tag.introduction ?? ""),
        const ButtonBar(),
      ],
    );
  }
}
