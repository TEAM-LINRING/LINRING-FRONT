import 'package:flutter/material.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';
import 'package:linring_front_flutter/widgets/custom_outlined_button.dart';
import 'package:linring_front_flutter/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
            backgroundColor: const Color(0xFFFFF6F4),
            appBar: const CustomAppBar(
              title: '회원가입',
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    //아이디
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '아이디',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ))),
                    const CustomTextField(
                      obscureText: false,
                      suffixText: Text('@kookmin.ac.kr'),
                    ),
                    const SizedBox(height: 30),
                    //비밀번호
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '비밀번호',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ))),
                    const CustomTextField(
                      hintText: '',
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //비밀번호 확인
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '비밀번호 확인',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ))),
                    const CustomTextField(
                      hintText: '',
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //닉네임
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
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
                    const CustomTextField(
                      hintText: '6글자 이내의 닉네임',
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //학과(제1전공)
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '학과(제1전공)',
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/selectmajor');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                width: 1, color: Color(0xFFC8AAAA)),
                            elevation: 5,
                            shadowColor: const Color(0x196C5916),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: const Size(350, 60),
                          ),
                          child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.search,
                                size: 24.0,
                                color: Colors.black,
                              ))),
                    ),

                    const SizedBox(height: 30),

                    //학번 및 학년
                    const Padding(
                        padding: EdgeInsets.only(left: 30.0),
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
                    const CustomTextField(
                      hintText: '',
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //성별 및 나이
                    const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
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
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xFFC8AAAA), width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: ToggleButtons(
                        isSelected: isSelected,
                        onPressed: toggleSelect,
                        fillColor: const Color(0xFFFEC2B5),
                        selectedColor: Colors.black,
                        children: const [
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              child: Text('여')),
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                              child: Text('남')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    //특이사항
                    const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '특이사항',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
                    const SizedBox(height: 40),
                    //가입하기 버튼
                    CustomOutlinedButton(
                        label: '가입하기',
                        onPressed: () {},
                        backgroundColor: const Color(0xFFFEC2B5)),
                  ]),
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
            side: const BorderSide(width: 1, color: Color(0xFFC8AAAA))),
        labelPadding: const EdgeInsets.all(7.0),
        label: Text(
          remark[index]['state'],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: const Color(0xFF1B1B1B),
              fontSize: 20,
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
}
