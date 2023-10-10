import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class TagShowScreen extends StatefulWidget {
  const TagShowScreen({Key? key}) : super(key: key);

  @override
  State createState() => _TagShowScreenState();
}

class _TagShowScreenState extends State<TagShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffff6f4),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 306.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5)),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Color(0xff3a3a3a)),
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Column(
            children: [
              const Text("어떤 친구를 만나게 될까요?"),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  enableInfiniteScroll: false,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return const Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text("북악관에서"),
                            Text("선배랑"),
                            Text("스터디하기"),
                            Text("같이 카페에서 각자 공부할 사람 구해요!"),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("상대방이 나를\n검색할 수 있어요."),
                                  ],
                                ),
                                Icon(Icons.search_rounded),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
