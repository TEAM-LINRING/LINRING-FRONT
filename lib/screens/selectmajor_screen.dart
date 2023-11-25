import 'package:flutter/material.dart';
import 'package:linring_front_flutter/major_data.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class SelectMajor extends StatelessWidget {
  final List<ListItem?> majorListItems =
      MajorData.getColleges().expand((college) {
    var items = <ListItem?>[CollegeItem(college.name)];
    items.addAll(college.majors.map((major) => MajorItem(major.name)));
    items.add(null);
    return items;
  }).toList();

  SelectMajor({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F4),
        appBar: CustomAppBar(
          title: '학과 선택',
        ),
        body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 70),
          itemCount: majorListItems.length,
          itemBuilder: (context, index) {
            final item = majorListItems[index];
            if (item == null) {
              return const Divider(color: Color.fromARGB(255, 118, 99, 99));
            }
            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: item.buildTitle(context),
              onTap: item is MajorItem
                  ? () {
                      // 현재 MajorItem의 값
                      String currentMajor = item.major;

                      // 이전 CollegeItem을 찾는 과정
                      int collegeIndex = index - 1;
                      while (collegeIndex >= 0 &&
                          majorListItems[collegeIndex] is! CollegeItem) {
                        collegeIndex--;
                      }

                      String currentCollege = "";
                      if (collegeIndex >= 0 &&
                          majorListItems[collegeIndex] is CollegeItem) {
                        currentCollege =
                            (majorListItems[collegeIndex] as CollegeItem)
                                .heading;
                      }

                      // 값을 딕셔너리에 저장
                      Map<String, String> result = {
                        'college': currentCollege,
                        'major': currentMajor
                      };

                      // 이전 페이지로 값을 반환
                      Navigator.pop(context, result);
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
}

class CollegeItem implements ListItem {
  final String heading;

  CollegeItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading,
        style: const TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold));
  }
}

class MajorItem implements ListItem {
  final String major;

  MajorItem(this.major);
  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      major,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}
