import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  LoginInfo loginInfo;
  ProfileScreen({required this.loginInfo, super.key});
  String? selectedCollege;
  String? selectedMajor;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nickNameController;
  late TextEditingController studentNumberController;
  late TextEditingController birthController;

  late String nickname;
  late int studnetNumber;
  late int birth;

  bool isNickNameUnique = false;
  //정규식 유효성 검사용 변수
  bool isPasswordValid = true;
  bool isPasswordConfirmValid = true;
  bool isNickNameValid = false;
  bool isSignUpButtonEnabled = false;

  String? helperID;
  String? helperNickName;
  String? errorID;
  String? errorNickName;

  //학과 선택용
  Map<String, String>? selectedData;

  //학번 및 학년 선택용
  List<String> gradeList = ['1학년', '2학년', '3학년', '4학년', '5학년', '졸업생', '기타'];
  String selectedGrade = '';

  //성별 선택용 변수들
  bool isMale = false;
  bool isFemale = false;

  late List<bool> isSelected;
  String selectedGender = '';

  //특이사항 선택용 변수들
  final List<Map<String, dynamic>> remark = [
    {'state': '유학생', 'isCheck': false},
    {'state': '전과생', 'isCheck': false},
    {'state': '편입생', 'isCheck': false},
    {'state': '외국인', 'isCheck': false},
    {'state': '교환학생', 'isCheck': false},
    {'state': '복수전공생', 'isCheck': false},
    {'state': '부전공생', 'isCheck': false},
    {'state': '휴학생', 'isCheck': false},
    //초기값 변경 필요
  ];

  @override
  void initState() {
    super.initState();
    selectedGender = widget.loginInfo.user.gender ?? "남";
    selectedGrade = widget.loginInfo.user.grade ?? "1학년";

    nickname = widget.loginInfo.user.nickname!;
    studnetNumber = widget.loginInfo.user.studentNumber!;
    birth = widget.loginInfo.user.birth!;

    nickNameController = TextEditingController(text: nickname);
    studentNumberController =
        TextEditingController(text: studnetNumber.toString());
    birthController = TextEditingController(text: birth.toString());

    selectedData = {
      'college': '기존 대학',
      'major': widget.loginInfo.user.department!
    };

    (widget.loginInfo.user.gender! == "남") ? isMale = true : isFemale = true;

    isSelected = [isMale, isFemale];
  }

  void _profileChange(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/user/');

    String body = jsonEncode({
      "nickname": nickNameController.text,
      "department": selectedData!['major'],
      "gender": selectedGender,
      "student_number": studentNumberController.text,
      "grade": selectedGrade,
      "significant": ["유학생", "전과생"]
    });
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    debugPrint((response.statusCode).toString());
    if (response.statusCode == 200) {
      if (!mounted) return;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         AccoutActiveScreen(email: '${idController.text}@kookmin.ac.kr'),
      //   ),
      // );
    }
  }

  Future<bool?> _validationNickName(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/v2/user/validation/nickname/');

    String emailBody = jsonEncode({
      "nickname": nickNameController.text,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: emailBody,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      //중복되지 않은 닉네임
      if (!mounted) {
        return null;
      }
      if (data['message'] == 'Nickname is available') {
        return true;
      }
    }

    if (response.statusCode == 400) {
      //이미 사용중인 닉네임
      if (!mounted) {
        return null;
      }
      if (data['message'] == 'Nickname is already in use') {
        return false;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F4),
      appBar: CustomAppBar(
        title: '프로필 관리',
        suffix: TextButton(
          onPressed: () {},
          child: const Text(
            '완료',
            style: TextStyle(fontSize: 19, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const SizedBox(
            height: 40,
          ),

          //닉네임
          const Padding(
              padding: EdgeInsets.only(left: 30.0, bottom: 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '닉네임',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ))),
          SizedBox(
            height: 100,
            child: Stack(alignment: Alignment.centerRight, children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: CustomTextField(
                  controller: nickNameController,
                  onChanged: (value) {
                    setState(() {
                      errorNickName = null;
                      helperNickName = null;
                      if (!RegExp(r'^[a-zA-Z0-9가-힣]*$').hasMatch(value)) {
                        isNickNameValid = false;
                        errorNickName = '닉네임에 공백이나 특수문자를 사용할 수 없습니다.';
                      } else if (value.length > 6) {
                        isNickNameValid = false;
                        errorNickName = '닉네임은 여섯글자 이내여야 합니다.';
                      } else {
                        errorNickName = null;
                        isNickNameValid = true;
                      }
                    });
                  },
                  errorText: errorNickName,
                  hintText: '6글자 이내의 닉네임',
                  obscureText: false,
                  helperText: helperNickName,
                ),
              ),
              Positioned(
                  right: 30,
                  bottom: 30,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 1, color: Color(0xFFC8AAAA)))),
                    child: OutlinedButton(
                        onPressed: () async {
                          if (isNickNameValid == true) {
                            bool? result = await _validationNickName(context);
                            setState(() {
                              if (result != null) {
                                if (result) {
                                  isNickNameUnique = true;
                                  errorNickName = null;
                                  helperNickName = '사용 가능한 닉네임입니다.';
                                } else {
                                  isNickNameUnique = false;
                                  helperNickName = null;
                                  errorNickName = '중복된 닉네임입니다. 다른 닉네임을 사용해주세요.';
                                }
                              }
                              isSignUpButtonEnabled = checkFormValidity();
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        child: const Text(
                          '중복 확인',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 0),
                        )),
                  )),
            ]),
          ),

          const SizedBox(height: 10),

          //학과(제1전공)
          const Padding(
              padding: EdgeInsets.only(left: 30.0, bottom: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '학과 (제1전공)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: OutlinedButton(
                onPressed: () async {
                  final result =
                      await Navigator.pushNamed(context, '/selectmajor');
                  if (result is Map<String, String>) {
                    setState(() {
                      selectedData = result;
                      isSignUpButtonEnabled = checkFormValidity();
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 1, color: Color(0xFFC8AAAA)),
                  elevation: 5,
                  shadowColor: const Color(0x196C5916),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(350, 60),
                ),
                child: Text(
                  "${selectedData!['college']}  -  ${selectedData!['major']}",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                )),
          ),

          const SizedBox(height: 30),

          //학번 및 학년
          const Padding(
              padding: EdgeInsets.only(left: 30.0, bottom: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '학번 및 학년',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ))),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFC8AAAA), width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1, color: Color(0xFFC8AAAA)))),
                    child: TextField(
                      controller: studentNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                        LengthLimitingTextInputFormatter(2) // 최대 4자리 제한
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: null,
                        contentPadding: EdgeInsets.fromLTRB(65, 14, 0, 0),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 45.0),
                          child: Align(
                            alignment: Alignment.center,
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Text(
                              '학번',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSignUpButtonEnabled = checkFormValidity();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: DropdownButton(
                        value: selectedGrade,
                        items: gradeList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedGrade = value!;
                          });
                        }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          //성별 및 나이
          const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '성별 및 나이',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ))),

          Container(
            //padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFC8AAAA), width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1, color: Color(0xFFC8AAAA)))),
                    child: ToggleButtons(
                      isSelected: isSelected,
                      onPressed: toggleSelect,
                      fillColor: const Color(0xFFFEC2B5),
                      selectedColor: Colors.black,
                      borderWidth: 0,
                      //borderRadius: const BorderRadius.all(Radius.circular(10)),
                      children: const [
                        Padding(
                            padding: EdgeInsets.fromLTRB(33, 5, 35, 5),
                            child: Text(
                              '남',
                              style: TextStyle(fontSize: 16),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(33, 5, 34, 5),
                            child: Text('여', style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextField(
                        controller: birthController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                          LengthLimitingTextInputFormatter(4) // 최대 4자리 제한
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: null,
                          contentPadding: EdgeInsets.fromLTRB(48, 15, 0, 0),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 45.0),
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(
                                '년생',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            isSignUpButtonEnabled = checkFormValidity();
                          });
                        },
                      ),
                    ))
              ],
            ),
          ),

          const SizedBox(height: 30),

          //특이사항
          const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        '특이사항',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '*선택사항',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 23, 5),
            child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(remark.length, (index) {
                  return buildRemark(index);
                })),
          ),

          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  void toggleSelect(value) {
    if (value == 0) {
      isMale = true;
      isFemale = false;
      selectedGender = '남';
    } else {
      isMale = false;
      isFemale = true;
      selectedGender = '여';
    }
    setState(() {
      isSelected = [isMale, isFemale];
      isSignUpButtonEnabled = checkFormValidity();
    });
  }

  Widget buildRemark(index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 6, 7),
      child: ChoiceChip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
        labelPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        label: Text(
          remark[index]['state'],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF1B1B1B),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        selected: remark[index]['isCheck'] == true,
        selectedColor: const Color(0xFFFEC2B5),
        onSelected: (value) {
          setState(() {
            remark[index]['isCheck'] = !remark[index]['isCheck'];
          });
        },
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  bool checkFormValidity() {
    return isNickNameUnique &&
        selectedData != null &&
        studentNumberController.text.isNotEmpty &&
        (isMale || isFemale) &&
        birthController.text.isNotEmpty;
  }
}
