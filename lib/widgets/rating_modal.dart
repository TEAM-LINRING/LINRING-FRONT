import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';

class RatingModal extends StatefulWidget {
  const RatingModal({super.key});

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  static const IconData star_rounded = IconData(
    0xf01d4,
    fontFamily: 'MaterialIcons',
  );
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
                    height: 270,
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
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '여섯글자이름님과 잘 만나고 오셨나요?',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '알고리즘 성능 향상을 위해',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                '매너평가를 남겨주세요!',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                            height: 330,
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
                                                        '여섯글자이름님과의 만남 매너 평가',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  RatingBar(
                                                    initialRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    ratingWidget: RatingWidget(
                                                      full: image(
                                                          'assets/images/fullStar.png'),
                                                      half: image(
                                                          'assets/images/fullStar.png'),
                                                      empty: image(
                                                          'assets/images/emptyStar.png'),
                                                    ),
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 4.0),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  const Text(
                                                    '별점을 남겨주세요.',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text(
                                                    '상대방은 평가 결과를 알 수 없으니 안심하세요!',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 10, 0),
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

  Widget image(String asset) {
    return Image.asset(
      asset,
      height: 25,
      width: 25,
    );
  }
}
