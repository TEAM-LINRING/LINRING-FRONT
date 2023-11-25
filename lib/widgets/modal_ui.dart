import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

//search detail modal ui 입니다.
class ModalUI extends StatefulWidget {
  const ModalUI({super.key});

  @override
  State<ModalUI> createState() => _ModalUIState();
}

class _ModalUIState extends State<ModalUI> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F4),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: const Text('Search detail Modal'),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                builder: (BuildContext context) {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 300,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: const Color(0xffc8c8c8),
                                                width: 0.7)),
                                        child: const Center(
                                            child: Image(
                                          image: AssetImage(
                                              'assets/images/avartar_1.png'),
                                          width: 100,
                                        )),
                                      ),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '여섯글자이름님',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '소프트웨어학부 21학번',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            '22살 여자 휴학생',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text(
                                  '"카페에서 같이 공부할 사람!"',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: CustomOutlinedButton(
                                  isActive: true,
                                  label: '이 친구와 채팅하기',
                                  backgroundColor: const Color(0xFFFEC2B5),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          )));
                },
              );
            },
          ),
        ]),
      ),
    );
  }

  Widget image(String asset) {
    return Image.asset(
      asset,
      height: 25,
      width: 25,
    );
  }
}
