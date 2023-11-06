import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linring_front_flutter/screens/accout_active_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});
  String? selectedCollege;
  String? selectedMajor;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final studentNumberController = TextEditingController();
  final ageController = TextEditingController();

  //중복 확인용 변수
  bool isIDUnique = false;
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
  String selectedGrade = '1학년';

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
  ];

  //동의 여부 확인용 변수들
  bool _isCheckedAll = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  List<String> check = [];

  @override
  void initState() {
    super.initState();
    isSelected = [isMale, isFemale];
    selectedGrade = gradeList[0];
  }

  void _createAccount(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/register/');

    // 특이사항에서 isCheck가 true인 항목들만의 state 값을 추출
    List<String> significantRemarks = remark
        .where((item) => item['isCheck'] == true)
        .map((item) => item['state'] as String)
        .toList();

    String body = jsonEncode({
      "name": nameController.text,
      "email": '${idController.text}@kookmin.ac.kr',
      "password1": passwordController.text,
      "password2": passwordConfirmController.text,
      "nickname": nickNameController.text,
      "college": selectedData!['college'],
      "department": selectedData!['major'],
      "profile": 1,
      "gender": selectedGender,
      "student_number": studentNumberController.text,
      "birth": ageController.text,
      "grade": selectedGrade,
      "significant": significantRemarks,
    });
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    debugPrint((response.statusCode).toString());
    if (response.statusCode == 201) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AccoutActiveScreen(email: '${idController.text}@kookmin.ac.kr'),
        ),
      );
    }
  }

  Future<bool?> _validationEmail(BuildContext context) async {
    String apiAddress = dotenv.env['API_ADDRESS'] ?? '';
    final url = Uri.parse('$apiAddress/accounts/v2/user/validation/email/');

    String emailBody = jsonEncode({
      "email": '${idController.text}@kookmin.ac.kr',
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
      //중복되지 않은 이메일
      if (!mounted) {
        return null;
      }
      if (data['message'] == 'email is available') {
        return true;
      }
    }

    if (response.statusCode == 400) {
      //이미 사용중인 이메일
      if (!mounted) {
        return null;
      }
      if (data['message'] == 'email is already in use') {
        return false;
      }
    }
    return null;
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
      appBar: const CustomAppBar(
        title: '회원가입',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const SizedBox(
            height: 40,
          ),
          //아이디

          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '아이디',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          SizedBox(
            height: 80,
            child: Stack(alignment: Alignment.centerRight, children: [
              CustomTextField(
                controller: idController,
                obscureText: false,
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 70.0),
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Text('@kookmin.ac.kr'),
                  ),
                ),
                helperText: helperID,
                errorText: errorID,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1, color: Color(0xFFC8AAAA)))),
                child: OutlinedButton(
                    onPressed: () async {
                      bool? result = await _validationEmail(context);
                      setState(() {
                        if (result != null) {
                          if (result) {
                            isIDUnique = true;
                            errorID = null;
                            helperID = '사용 가능한 메일주소입니다.';
                          } else {
                            isIDUnique = false;
                            helperID = null;
                            errorID = '이미 존재하는 계정입니다. 로그인해주세요.';
                          }

                          isSignUpButtonEnabled = checkFormValidity();
                        }
                      });
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 20)),
                    child: const Text(
                      '중복 확인',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 0),
                    )),
              ),
            ]),
          ),
          const SizedBox(height: 30),
          //비밀번호
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          CustomTextField(
            controller: passwordController,
            onChanged: (value) {
              final regex =
                  RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_])[a-zA-Z\d\W_]*$');

              setState(() {
                isPasswordValid = regex.hasMatch(value);
                isSignUpButtonEnabled = checkFormValidity();
              });
            },
            obscureText: true,
            errorText:
                isPasswordValid ? null : '비밀번호는 영문자와 숫자를 조합해 8자리 이상이어야 합니다.',
          ),

          const SizedBox(height: 30),

          //비밀번호 확인
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '비밀번호 확인',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          CustomTextField(
            obscureText: true,
            controller: passwordConfirmController,
            onChanged: (value) {
              setState(() {
                isPasswordConfirmValid = passwordController.text == value;
                isSignUpButtonEnabled = checkFormValidity();
              });
            },
            errorText: isPasswordConfirmValid ? null : '비밀번호가 일치하지 않습니다.',
          ),

          const SizedBox(height: 30),

          //이름
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '이름',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          CustomTextField(
            controller: nameController,
            obscureText: false,
            onChanged: (value) {
              setState(() {
                isSignUpButtonEnabled = checkFormValidity();
              });
            },
          ),

          const SizedBox(height: 30),

          //닉네임
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '닉네임',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          SizedBox(
            height: 80,
            child: Stack(alignment: Alignment.centerRight, children: [
              CustomTextField(
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
                            padding: const EdgeInsets.symmetric(vertical: 20)),
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

          const SizedBox(height: 30),

          //학과(제1전공)
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '학과 (제1전공)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          OutlinedButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/selectmajor');
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
            child: selectedData == null
                ? const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.search,
                      size: 24.0,
                      color: Colors.black,
                    ))
                : Text(
                    "${selectedData!['college']}  -  ${selectedData!['major']}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
          ),

          const SizedBox(height: 30),

          //학번 및 학년
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '학번 및 학년',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),
          Container(
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
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '성별 및 나이',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )),

          Container(
            clipBehavior: Clip.hardEdge,
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
                        controller: ageController,
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
          const Align(
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
              )),

          Wrap(
              alignment: WrapAlignment.start,
              children: List.generate(remark.length, (index) {
                return buildRemark(index);
              })),

          const SizedBox(height: 30),

          //동의
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: _isCheckedAll,
                    onChanged: (value) {
                      setState(() {
                        _isCheckedAll = value!;
                        _isChecked1 = value;
                        _isChecked2 = value;
                        isSignUpButtonEnabled = checkFormValidity();
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return null;
                    }),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) =>
                          const BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                '전체 동의',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
                        _isCheckedAll = _isChecked1 && _isChecked2;
                        isSignUpButtonEnabled = checkFormValidity();
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return null;
                    }),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) =>
                          const BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                '(필수) 허위사실 기재시 서비스 이용이 제한됨을 인지했어요.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
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
                        _isCheckedAll = _isChecked1 && _isChecked2;
                        isSignUpButtonEnabled = checkFormValidity();
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return null;
                    }),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                      (states) =>
                          const BorderSide(width: 1.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: '(필수) ',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
                TextSpan(
                    text: '이용약관',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(
                            'https://www.notion.so/kkamantokki/21a25cf722a84c98b576da0149b04eae?pvs=4'));
                      }),
                const TextSpan(
                    text: ' 및 ',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
                TextSpan(
                    text: '개인정보수집이용',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(
                            'https://www.notion.so/kkamantokki/10be477f20dd4039b3c84af83d7d570e?pvs=4'));
                      }),
                const TextSpan(
                    text: '에 동의해요.',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ]))
            ],
          ),

          const SizedBox(height: 30),

          //가입하기 버튼
          CustomOutlinedButton(
            label: '가입하기',
            onPressed: isSignUpButtonEnabled
                ? () {
                    // 회원가입 로직
                    _createAccount(context);
                  }
                : () {},
            backgroundColor: isSignUpButtonEnabled
                ? const Color(0xFFFEC2B5)
                : const Color(0xFFC8C8C8),
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
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: ChoiceChip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(width: 2, color: Color(0xFFFEC2B5))),
        labelPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
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
    // debugPrint(isIDUnique.toString());
    // debugPrint(isPasswordValid.toString());
    // debugPrint(isPasswordConfirmValid.toString());
    // debugPrint(isNickNameUnique.toString());
    // debugPrint((selectedData != null).toString());
    // debugPrint((studentNumberController.text.isNotEmpty).toString());
    return isIDUnique &&
        isPasswordValid &&
        isPasswordConfirmValid &&
        isNickNameUnique &&
        selectedData != null &&
        studentNumberController.text.isNotEmpty &&
        (isMale || isFemale) &&
        ageController.text.isNotEmpty &&
        ((_isChecked1 && _isChecked2));
  }
}
