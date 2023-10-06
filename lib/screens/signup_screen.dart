import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //성별 선택용 변수들
  bool isMale = false;
  bool isFemale = false;
  late List<bool> isSelected;

  //특이사항 선택용 변수들
  final List<Map<String, dynamic>> remark = [
    {'state': '유학생', 'isCheck': false},
    {'state': '전과생', 'isCheck': false},
    {'state': '편입생', 'isCheck': false},
    {'state': '외국인', 'isCheck': false},
    {'state': '교환학생', 'isCheck': false},
    {'state': '복수전공생', 'isCheck': false},
    {'state': '부전공생', 'isCheck': false},
  ];

  @override
  void initState() {
    isSelected = [isMale, isFemale];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFFFF6F4),
            appBar: CustomAppBar(
              title: '회원가입',
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      //아이디
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '아이디',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      CustomTextField(
                        hintText: 'abc123@kookmin.com',
                        obscureText: false,
                      ),
                      SizedBox(height: 30),
                      //비밀번호
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '비밀번호',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      CustomTextField(
                        hintText: '',
                        obscureText: false,
                      ),

                      SizedBox(height: 30),

                      //비밀번호 확인
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '비밀번호 확인',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      CustomTextField(
                        hintText: '',
                        obscureText: false,
                      ),

                      SizedBox(height: 30),

                      //닉네임
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '닉네임',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      CustomTextField(
                        hintText: '6글자 이내의 닉네임',
                        obscureText: false,
                      ),

                      SizedBox(height: 30),

                      //학과(제1전공)
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '학과(제1전공)',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/selectmajor');
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFC8AAAA)),
                              elevation: 5,
                              shadowColor: Color(0x196C5916),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: Size(350, 60),
                            ),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.search,
                                  size: 24.0,
                                  color: Colors.black,
                                ))),
                      ),

                      SizedBox(height: 30),

                      //학번 및 학년
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '학번 및 학년',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      CustomTextField(
                        hintText: '',
                        obscureText: false,
                      ),

                      SizedBox(height: 30),

                      //성별 및 나이
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '성별 및 나이',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xFFC8AAAA), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: ToggleButtons(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                child: Text('여')),
                            Padding(
                                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                child: Text('남')),
                          ],
                          isSelected: isSelected,
                          onPressed: toggleSelect,
                          fillColor: Color(0xFFFEC2B5),
                          selectedColor: Colors.black,
                        ),
                      ),

                      SizedBox(height: 30),

                      //특이사항
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '특이사항',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))),
                      Wrap(
                          alignment: WrapAlignment.start,
                          children: List.generate(remark.length, (index) {
                            return buildRemark(index);
                          })),

                      //동의
                      SizedBox(height: 40),
                      //가입하기 버튼
                      CustomOutlinedButton(
                          label: '가입하기',
                          onPressed: () {},
                          backgroundColor: Color(0xFFFEC2B5)),
                    ]),
              ),
            )));
  }

  void toggleSelect(value) {
    if (value == 0) {
      isMale = true;
      isFemale = false;
    } else {
      isMale = false;
      isFemale = true;
    }
    setState(() {
      isSelected = [isMale, isFemale];
    });
  }

  Widget buildRemark(index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: ChoiceChip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1, color: Color(0xFFC8AAAA))),
        labelPadding: EdgeInsets.all(7.0),
        label: Text(
          remark[index]['state'],
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: const Color(0xFF1B1B1B),
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400),
        ),
        selected: remark[index]['isCheck'] == true,
        selectedColor: Color(0xFFFEC2B5),
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
}