import 'package:flutter/material.dart';
import 'package:linring_front_flutter/major_data.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class SelectMajor extends StatelessWidget {
  final List<ListItem?> majorListItems =
      MajorDataProvider.getColleges().expand((college) {
    var items = <ListItem?>[HeadingItem(college.name)];
    items.addAll(college.majors.map((major) => MessageItem(major.name)));
    items.add(null);
    return items;
  }).toList();

  SelectMajor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(
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
            onTap: item is MessageItem
                ? () {
                    Navigator.pushNamed(context, '/signup');
                    // 예: 학과 이름을 표시하는 토스트 메시지를 표시
                    // final title = item.buildTitle(context).toString();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('$title was tapped!')),
                    // );
                  }
                : null,
          );
        },
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading,
        style: const TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold));
  }
}

class MessageItem implements ListItem {
  //final String sender;
  final String body;

  MessageItem(this.body);
  @override
  Widget buildTitle(BuildContext context) => Text(
        body,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      );
}
