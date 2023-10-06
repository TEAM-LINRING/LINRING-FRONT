import 'package:flutter/material.dart';
import 'package:linring_front_flutter/major_data.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class SelectMajor extends StatelessWidget {
  final List<ListItem> majorListItems =
      MajorDataProvider.getColleges().expand((college) {
    return [
      HeadingItem(college.name),
      ...college.majors.map((major) => MessageItem('', major.name))
    ];
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
        padding: const EdgeInsets.all(0),
        itemCount: majorListItems.length,
        itemBuilder: (context, index) {
          final item = majorListItems[index];
          return SafeArea(
            child: ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              onTap: item is MessageItem
                  ? () {
                      Navigator.pushNamed(context, '/signup');
                      // 예: 학과 이름을 표시하는 토스트 메시지를 표시
                      // final title = item.buildTitle(context).toString();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('$title was tapped!')),
                      // );
                    }
                  : null, // HeadingItem에는 onTap 콜백을 추가하지 않습니다.
            ),
          );
        },
      ),
    );
  }
}

// The rest of the ListItem, HeadingItem, and MessageItem classes remains unchanged.
abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
