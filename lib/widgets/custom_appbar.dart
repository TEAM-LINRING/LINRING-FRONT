import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title, onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w500,
            height: 0),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () => {
                if (Navigator.of(context).canPop())
                  {Navigator.of(context).pop()} //뒤로가기
              },
          color: const Color.fromARGB(255, 0, 0, 0),
          icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar의 기본 높이
}
