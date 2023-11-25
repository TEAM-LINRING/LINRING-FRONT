import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/screens/delete_account.dart';
import 'package:linring_front_flutter/screens/profile_screen.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  LoginInfo loginInfo;
  SettingScreen({required this.loginInfo, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static const storage = FlutterSecureStorage();
  late List<SvgPicture> profileItem;
  late int? selectedIndex = widget.loginInfo.user.profile;
  late int? ChangedIndex = widget.loginInfo.user.profile;
  late int? currentIndex = widget.loginInfo.user.profile;
  late String? nickname = widget.loginInfo.user.nickname;
  late String? college = widget.loginInfo.user.college;
  late String? department = widget.loginInfo.user.department;
  late int? studentNumber = widget.loginInfo.user.studentNumber;

  late List<String> profileImagePaths;
  _logout(BuildContext context) async {
    await storage.delete(key: 'user');
  }

  @override
  void initState() {
    super.initState();

    profileImagePaths = [
      'assets/images/characters/01.svg',
      'assets/images/characters/02.svg',
      'assets/images/characters/03.svg',
      'assets/images/characters/04.svg',
      'assets/images/characters/05.svg',
      'assets/images/characters/06.svg',
      'assets/images/characters/07.svg',
      'assets/images/characters/08.svg',
    ];

    profileItem = List.generate(
      profileImagePaths.length,
      (index) => SvgPicture.asset(
        profileImagePaths[index],
        width: 100,
        height: 100,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  void _updateProfile() async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url = Uri.parse('$apiAddress/accounts/user/');
    final token = widget.loginInfo.access;
    final body = jsonEncode({"profile": ChangedIndex});
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print(body);
    print(response.statusCode);
  }

  void _updateUserInfo() async {
    /*
    사용자 정보 변경이 있는 경우
    기존 loginInfo를 갱신
    */
  }

  Future _displayProfileSheet(BuildContext context) {
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
                                selectedIndex = index + 1;
                              },
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIndex == index + 1
                                    ? const Color(0xffc8aaaa)
                                    : Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: profileItem[index],
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
                    onPressed: () {
                      Navigator.pop(context);
                      ChangedIndex = selectedIndex;
                      setState(
                        () {
                          _updateProfile();
                        },
                      );
                    },
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

  Future _displayPreparingService(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black87.withOpacity(0.7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 48,
                    height: 20,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "서비스 준비중입니다.",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        );
      },
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xffc8aaaa),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 6, 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$nickname님",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ), // 이름
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$college",
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text("$department $studentNumber"),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 40),
                              width: 100,
                              height: 100,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            Positioned(
                              width: 90,
                              height: 90,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xffc8c8c8),
                                        width: 0.7)),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/images/characters/0$ChangedIndex.svg'),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  _displayProfileSheet(context)
                                      .then((value) => setState(() {
                                            currentIndex = ChangedIndex;
                                            selectedIndex = ChangedIndex;
                                          }));
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
              _settingItems(
                "공식 Notion 페이지로 이동",
                false,
                () {
                  launchUrl(Uri.parse(
                      'https://possible-rowboat-b63.notion.site/444456a5fef44d23bdd3b2181bacfb15?pvs=4'));
                },
              ),
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
                  ).then((value) async {
                    String? res = await storage.read(key: 'user');
                    final Map parsed = json.decode(utf8.decode(res!.codeUnits));
                    final loginInfo = LoginInfo.fromJson(parsed);
                    setState(() {
                      widget.loginInfo = loginInfo;

                      nickname = loginInfo.user.nickname;
                      college = loginInfo.user.college;
                      department = loginInfo.user.department;
                      studentNumber = loginInfo.user.studentNumber;
                    });
                  });
                },
              ),
              // _settingItems("친구 초대", false, () {
              //   _displayPreparingService(context);
              // }),
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
      ),
    );
  }
}
