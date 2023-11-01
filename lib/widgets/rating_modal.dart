import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class RatingModal extends StatefulWidget {
  const RatingModal({super.key});

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      body: Center(
        child: ElevatedButton(
          child: const Text('show RatingModal'),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              builder: (BuildContext context) {
                return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 280,
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
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
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                              child: Text(
                                '여섯글자이름님과 잘 만나고 오셨나요?',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                              child: Text(
                                '알고리즘 성능 향상을 위해',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Text(
                                '매너평가를 남겨주세요!',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                              child: CustomOutlinedButton(
                                label: '상대방 매너평가 남기기',
                                backgroundColor: const Color(0xFFFEC2B5),
                                onPressed: () {
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            height: 300,
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(
                                                        width: 48,
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        '여섯글자이름님과의 만남은 ...',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.close_rounded,
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                    '최고의 만남이었어요!',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    '안심하세요! 상대방은 평가 결과를 알 수 없어요.',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0x99999999),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 20, 0),
                                                      child: CustomOutlinedButton(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFFEC2B5),
                                                          label: '상대방 매너평가 남기기',
                                                          onPressed: () {}))
                                                ])));
                                      });
                                },
                              ),
                            )
                          ],
                        )));
              },
            );
          },
        ),
      ),
    );
  }
}
