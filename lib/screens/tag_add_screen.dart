import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  const TagAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "태그 추가하기"),
      body: Column(children: [
        ChoiceLocation(),
      ]),
    );
  }
}

// 장소 선택
class ChoiceLocation extends StatefulWidget {
  const ChoiceLocation({super.key});

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

    String body = jsonEncode({
      "place": place,
      "isSameDepartment": isSameDepartment,
      "person": person,
      "method": method,
      "is_active": true,
      "introduction": introduction,
      "owner": 1, // owner는 추후 변경 예정
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      if (!mounted) return;
      Navigator.pushNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: _tagPlace.map((tag) {
            return ChoiceChip(
              label: Text(tag.title),
              selected: place == tag.title,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    place = tag.title;
                  } else {
                    place = null;
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8,
          children: _tagDepartment.map((tag) {
            return ChoiceChip(
              label: Text(tag.title),
              selected: department == tag.title,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    department = tag.title;
                  } else {
                    department = null;
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8,
          children: _tagPerson.map((tag) {
            return ChoiceChip(
              label: Text(tag.title),
              selected: person == tag.title,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    person = tag.title;
                  } else {
                    person = null;
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8,
          children: _tagMethod.map((tag) {
            return ChoiceChip(
              label: Text(tag.title),
              selected: method == tag.title,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    method = tag.title;
                  } else {
                    method = null;
                  }
                });
              },
            );
          }).toList(),
        ),
        CustomTextField(
          onChanged: (value) => {introduction = value},
          obscureText: false,
          hintText: "ex. 같이 카페에서 각자 공부할 사람 구해요!",
        ),
        CustomOutlinedButton(
            label: '저장',
            onPressed: () {
              if (place != null &&
                  department != null &&
                  person != null &&
                  method != null) {
                _createTagset(context);
              }
            },
            backgroundColor: const Color(0xfffec2b5))
      ],
    );
  }
}
