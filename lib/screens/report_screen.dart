import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:linring_front_flutter/models/chat_model.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReportScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  final ChatRoom room;
  ReportScreen({required this.loginInfo, required this.room, super.key});
  String? selectedCollege;
  String? selectedMajor;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  dynamic reasonNumber;
  dynamic reasonTextController;

  late User opponentUser;

  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  final report1Controller = TextEditingController();
  final report2Controller = TextEditingController();
  final report3Controller = TextEditingController();
  final report4Controller = TextEditingController();

  void _createReport(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/report/report/');
    final token = widget.loginInfo.access;

    String body = jsonEncode({
      "reason": '$reasonNumber',
      "description": reasonTextController.text,
      "user": widget.loginInfo.user.id,
      "target": opponentUser.id
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    debugPrint((response.statusCode).toString());
    debugPrint(body);
    if (response.statusCode == 201) {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    (widget.loginInfo.user.id == widget.room.relation2.id)
        ? {
            opponentUser = widget.room.relation,
          }
        : {
            opponentUser = widget.room.relation2,
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: const CustomAppBar(
        title: '신고하기',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 30.0, bottom: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '신고대상',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${opponentUser.nickname}님",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 30.0, bottom: 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '사용자 신고 사유를 선택해주세요',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _isChecked1,
                            onChanged: (value) {
                              setState(() {
                                _isChecked1 = value!;
                                _isChecked2 = false;
                                _isChecked3 = false;
                                _isChecked4 = false;
                                reasonNumber = 1;
                                reasonTextController = report1Controller;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '욕설을 사용했어요',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  if (_isChecked1)
                    const SizedBox(
                      height: 10,
                    ),
                  if (_isChecked1)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                      child: TextField(
                        controller: report1Controller,
                        maxLength: 100,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                '(선택사항) 신고 내용을 직접 작성해주세요. 신고 처리에 큰 도움이 됩니다. 100자 이내 작성',
                            hintMaxLines: 2),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _isChecked2,
                            onChanged: (value) {
                              setState(() {
                                _isChecked2 = value!;
                                _isChecked1 = false;
                                _isChecked3 = false;
                                _isChecked4 = false;
                                reasonNumber = 2;
                                reasonTextController = report2Controller;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '약속 장소에 나오지 않았어요',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  if (_isChecked2)
                    const SizedBox(
                      height: 10,
                    ),
                  if (_isChecked2)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                      child: TextField(
                        controller: report2Controller,
                        maxLength: 100,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                '(선택사항) 신고 내용을 직접 작성해주세요. 신고 처리에 큰 도움이 됩니다. 100자 이내 작성',
                            hintMaxLines: 2),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _isChecked3,
                            onChanged: (value) {
                              setState(() {
                                _isChecked3 = value!;
                                _isChecked1 = false;
                                _isChecked2 = false;
                                _isChecked4 = false;
                                reasonNumber = 3;
                                reasonTextController = report3Controller;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '비매너 사용자예요',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  if (_isChecked3)
                    const SizedBox(
                      height: 10,
                    ),
                  if (_isChecked3)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                      child: TextField(
                        controller: report3Controller,
                        maxLength: 100,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                '(선택사항) 신고 내용을 직접 작성해주세요. 신고 처리에 큰 도움이 됩니다. 100자 이내 작성',
                            hintMaxLines: 2),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _isChecked4,
                            onChanged: (value) {
                              setState(() {
                                _isChecked4 = value!;
                                _isChecked1 = false;
                                _isChecked2 = false;
                                _isChecked3 = false;
                                reasonNumber = 4;
                                reasonTextController = report4Controller;
                              });
                            },
                            checkColor: Colors.black,
                            activeColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.white;
                            }),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '기타 사유',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  if (_isChecked4)
                    const SizedBox(
                      height: 10,
                    ),
                  if (_isChecked4)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                      child: TextField(
                        controller: report4Controller,
                        maxLength: 100,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                '(선택사항) 신고 내용을 직접 작성해주세요. 신고 처리에 큰 도움이 됩니다. 100자 이내 작성',
                            hintMaxLines: 2),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 0, 17),
              child: Row(
                children: [
                  Icon(
                    Icons.report,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '허위 신고가 누적되면 서비스 이용이 제한됩니다.\n신고 제출시, 운영자의 검토 후 조치합니다.',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CustomOutlinedButton(
                label: '제출하기',
                onPressed: () {
                  _createReport(context);
                },
                backgroundColor: const Color(0xFFFEC2B5),
                isActive:
                    (_isChecked1 || _isChecked2 || _isChecked3 || _isChecked4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
