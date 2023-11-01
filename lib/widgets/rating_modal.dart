import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class RatingModal extends StatelessWidget {
  const RatingModal({
    super.key,
  });

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
                          color: Colors.white, // 모달 배경색
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
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
                                'OO님과 잘 만나고 오셨나요?',
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
                                onPressed: () {},
                                backgroundColor: const Color(0xFFFEC2B5),
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
