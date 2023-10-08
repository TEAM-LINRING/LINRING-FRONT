import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

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
  Tag? _selectedLocation;

  final List<Tag> _tagLocation = [
    Tag(id: '1', title: '북악관'),
    Tag(id: '2', title: '예술대'),
    Tag(id: '3', title: '미래관'),
    Tag(id: '4', title: '공학관'),
    Tag(id: '5', title: '경상관'),
    Tag(id: '6', title: '본부관'),
    Tag(id: '7', title: '용두리'),
    Tag(id: '8', title: '도서관'),
    Tag(id: '9', title: '복지관 열람실'),
    Tag(id: '10', title: '자율주행스튜디오'),
    Tag(id: '11', title: '어디서든'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          children: _tagLocation.map((tag) {
            return ChoiceChip(
              label: Text(tag.title),
              selected: _selectedLocation == tag,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedLocation = tag;
                  } else {
                    _selectedLocation = null;
                  }
                });
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
