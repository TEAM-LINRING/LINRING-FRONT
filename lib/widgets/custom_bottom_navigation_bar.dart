import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xff6c5916),
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: widget.selectedIndex,
            onTap: (index) {
              setState(() {
                widget.onIndexChanged(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/home_empty.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/home_filled.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                label: '메인',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/chat_empty.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/chat_filled.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/settings_empty.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/icons/settings_filled.png",
                    width: 32,
                    height: 32,
                  ),
                ),
                label: '설정',
              ),
            ],
            backgroundColor: Colors.white,
            unselectedItemColor: const Color(0xff999999),
            selectedItemColor: const Color(0xff999999),
            selectedLabelStyle: const TextStyle(fontSize: 11),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
          ),
        ),
      ),
    );
  }
}
