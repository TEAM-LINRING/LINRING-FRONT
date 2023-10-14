import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:http/http.dart' as http;

class TagShowScreen extends StatefulWidget {
  const TagShowScreen({Key? key}) : super(key: key);

  @override
  State createState() => _TagShowScreenState();
}

class _TagShowScreenState extends State<TagShowScreen> {
  late Future<List<tagset>> _futureTagsets;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureTagsets = _callAPI();
  }

  Future<List<tagset>> _callAPI() async {
    // final url = Uri.parse(dotenv.get('API_URL'));
    final url = Uri.parse('http://127.0.0.1:8000/api/accounts/v2/tagset/');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      List<tagset> tagsets =
          body.map((dynamic e) => tagset.fromJson(e)).toList();
      return tagsets;
    } else {
      throw Exception('Failed to load tagset.');
    }
  }

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
              FutureBuilder(
                future: _futureTagsets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("에러 ${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return const Text("데이터 없음.");
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 320.0,
                        enableInfiniteScroll: false,
                      ),
                      items: snapshot.data!.map((tag) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${tag.place}에서\n${(tag.isSameDepartment) ? "같은 과" : "다른 과"} ${tag.person}랑\n${tag.method}하기",
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      tag.introduction != null
                                          ? "\"${tag.introduction}\""
                                          : "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 64,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            const Text(
                                              "상대방이 나를\n검색할 수 있어요.",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff999999),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child: CupertinoSwitch(
                                                  activeColor:
                                                      const Color(0xff57e554),
                                                  value: tag.isActive,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Icon(
                                          Icons.search_rounded,
                                          color: Color(0xfffec2b5),
                                          size: 37,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
