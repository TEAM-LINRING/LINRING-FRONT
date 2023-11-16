import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/chat_room_screen.dart';
import 'package:linring_front_flutter/screens/main_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? suffix;
  final LoginInfo? loginInfo;
  const CustomAppBar({
    super.key,
    required this.title,
    this.suffix,
    this.loginInfo,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            height: 0),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () => {
                if (loginInfo != null)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(loginInfo!, 1),
                      ),
                    ),
                  }
                else if (Navigator.of(context).canPop())
                  {print('pop!'), Navigator.of(context).pop()} //뒤로가기
              },
          color: const Color.fromARGB(255, 0, 0, 0),
          icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        if (suffix != null) suffix!,
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar의 기본 높이
}
