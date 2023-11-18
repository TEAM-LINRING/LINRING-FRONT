import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;

class Tag {
  String id;
  String title;

  Tag({
    required this.id,
    required this.title,
  });
}

class TagAddScreen extends StatelessWidget {
  final LoginInfo loginInfo;
  const TagAddScreen({required this.loginInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: "태그 추가하기"),
      backgroundColor: const Color(0xfffff6f4),
      body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Column(children: [
              ChoiceLocation(info: loginInfo),
            ]),
          ]),
    );
  }
}

// 장소 선택
class ChoiceLocation extends StatefulWidget {
  final LoginInfo info;
  const ChoiceLocation({required this.info, super.key});

  @override
  State<ChoiceLocation> createState() => _ChoiceLocationState();
}

class _ChoiceLocationState extends State<ChoiceLocation> {
  String? place;
  String? department;
  String? person;
  String? method;
  String? introduction;

  final List<Tag> _tagPlace = [
    Tag(id: '1', title: '북악관'),
    Tag(id: '2', title: '예술관'),
    Tag(id: '3', title: '복지관'),
    Tag(id: '4', title: '공학관'),
    Tag(id: '5', title: '법학관'),
    Tag(id: '6', title: '대운동장'),
    Tag(id: '7', title: '도서관'),
    Tag(id: '8', title: '교내 생활관'),
    Tag(id: '9', title: '웰니스'),
    Tag(id: '10', title: '빵집'),
    Tag(id: '11', title: '교내 카페'),
    Tag(id: '11', title: '학생식당'),
    Tag(id: '11', title: '아무데나'),
  ];

  final List<Tag> _tagDepartment = [
    Tag(id: '0', title: '같은 과'),
    Tag(id: '1', title: '다른 과'),
  ];

  final List<Tag> _tagPerson = [
    Tag(id: '1', title: '선배'),
    Tag(id: '2', title: '동기'),
    Tag(id: '3', title: '후배'),
  ];

  final List<Tag> _tagMethod = [
    Tag(id: '1', title: '공부'),
    Tag(id: '2', title: '수다'),
    Tag(id: '3', title: '카페'),
    Tag(id: '4', title: '산책'),
    Tag(id: '5', title: '운동'),
    Tag(id: '6', title: '친구'),
  ];

  void _createTagset(BuildContext context) async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url = Uri.parse('$apiAddress/accounts/v2/tagset/');
    bool isSameDepartment = (department == '같은 과') ? true : false;

    final owner = widget.info.user.id;
    final token = widget.info.access;

    String body = jsonEncode({
      "place": place,
      "isSameDepartment": isSameDepartment,
      "person": person,
      "method": method,
      "is_active": true,
      "introduction": introduction,
      "owner": owner,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 156,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0xffc8aaaa),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    place ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "에서",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            children: _tagPlace.map((tag) {
              return ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
                labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                label: Text(tag.title),
                selected: place == tag.title,
                selectedColor: const Color(0xfffec2b5),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      place = tag.title;
                    } else {
                      place = null;
                    }
                  });
                },
                backgroundColor: Colors.white,
                elevation: 0,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 100,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0xffc8aaaa),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    department ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                width: 70,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0xffc8aaaa),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    person ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "(이)랑",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            children: _tagDepartment.map(
              (tag) {
                return ChoiceChip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side:
                          const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
                  labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  label: SizedBox(
                    width: 50,
                    child: Text(
                      tag.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xff1b1b1b),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  selected: department == tag.title,
                  selectedColor: const Color(0xfffec2b5),
                  onSelected: (selected) {
                    setState(
                      () {
                        if (selected) {
                          department = tag.title;
                        } else {
                          department = null;
                        }
                      },
                    );
                  },
                  backgroundColor: Colors.white,
                  elevation: 0,
                );
              },
            ).toList(),
          ),
          Wrap(
            spacing: 8,
            children: _tagPerson.map((tag) {
              return ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
                labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                label: SizedBox(
                  width: 50,
                  child: Text(
                    tag.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                selected: person == tag.title,
                selectedColor: const Color(0xFFFEC2B5),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      person = tag.title;
                    } else {
                      person = null;
                    }
                  });
                },
                backgroundColor: Colors.white,
                elevation: 0,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 156,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: Color(0xffc8aaaa),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    method ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  method == "카페" ? "가기" : "하기",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            children: _tagMethod.map(
              (tag) {
                return ChoiceChip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side:
                          const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
                  labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  label: Text(tag.title),
                  selected: method == tag.title,
                  selectedColor: const Color(0xFFFEC2B5),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        method = tag.title;
                      } else {
                        method = null;
                      }
                    });
                  },
                  backgroundColor: Colors.white,
                  elevation: 0,
                );
              },
            ).toList(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "한줄 소개 (30자 이내)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            textLimit: 30,
            onChanged: (value) => {
              introduction = value,
              setState(
                () {},
              )
            },
            obscureText: false,
            hintText: "ex. 같이 카페에서 각자 공부할 사람 구해요!",
            padding: const EdgeInsets.all(0.0),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomOutlinedButton(
            label: '저장하기',
            onPressed: () {
              _createTagset(context);
            },
            isActive: (place != null &&
                department != null &&
                person != null &&
                method != null &&
                introduction != null &&
                introduction != ""),
            backgroundColor: const Color(0xfffec2b5),
          )
        ],
      ),
    );
  }
}
