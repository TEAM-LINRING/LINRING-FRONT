import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/delete_account.dart';
import 'package:linring_front_flutter/screens/profile_screen.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class SettingScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  const SettingScreen({required this.loginInfo, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static const storage = FlutterSecureStorage();

  _logout(BuildContext context) async {
    await storage.delete(key: 'user');
  }

  final profileItem = [
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
    Image.asset('assets/images/avartar_1.png'),
  ];

  Future _displayProfileSheet(BuildContext context) {
    int selectedIndex = 0;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black87.withOpacity(0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 400,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "프로필 이미지",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 24),
                    child: GridView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // ListView Scroll 제한
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1 / 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: profileItem.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedIndex = index;
                              },
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIndex == index
                                    ? const Color(0xffc8aaaa)
                                    : Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: profileItem[index].image,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutlinedButton(
                    label: '저장하기',
                    onPressed: () {},
                    backgroundColor: const Color(0xfffec2b5),
                    isActive: true,
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _settingItems(String title, bool isLast, Function onTapAction) {
    return InkWell(
      onTap: () {
        onTapAction();
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? const Border()
              : const Border(
                  bottom: BorderSide(
                    color: Color(0xffc8aaaa),
                  ),
                ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff6f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "설정",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xffc8aaaa),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.loginInfo.user.nickname} 님",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ), // 이름
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.loginInfo.user.college}",
                          ), // 단과대학 <- 현재 단과대학을 저장하는 field가 존재하지 않음 (11/04)
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                              "${widget.loginInfo.user.department} ${widget.loginInfo.user.studentNumber}"), // 학부 or 학과 + 학번
                        ],
                      ),
                      Stack(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xffd9d9d9),
                            radius: 42,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                _displayProfileSheet(context);
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xff999999),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Color(0xff999999),
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            _settingItems("공지사항 및 이벤트", false, () {}),
            _settingItems(
              "프로필 관리",
              false,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      loginInfo: widget.loginInfo,
                    ),
                  ),
                );
              },
            ),
            _settingItems("친구 초대", false, () {}),
            _settingItems("비밀번호 변경", false, () {
              Navigator.pushNamed(context, '/forgotPassword');
            }),
            _settingItems("서비스 탈퇴하기", false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccountScreen(
                    loginInfo: widget.loginInfo,
                  ),
                ),
              );
            }),
            _settingItems("로그아웃", true, () {
              _logout(context);
              Navigator.pushNamed(context, '/login');
            }),
          ],
        ),
      ),
    );
  }
}
