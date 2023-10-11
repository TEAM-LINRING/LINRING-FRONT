class College {
  final String name;
  final List<Major> majors;

  College(this.name, this.majors);
}

class Major {
  final String name;

  Major(this.name);
}

class MajorDataProvider {
  static final List<College> colleges = [
    College('글로벌인문지역대학', [
      Major('한국어문학부'),
      Major('영어영문학부'),
      Major('중국학부'),
      Major('한국역사학과'),
    ]),
    College('사회과학대학', [
      Major('행정학과'),
      Major('행정관리학과'),
      Major('정치외교학과'),
      Major('사회학과'),
      Major('미디어광고학부'),
      Major('교육학과'),
      Major('러시아유라시아학과'),
      Major('일본학과'),
    ]),
    College('법과대학', [
      Major('법학부'),
      Major('기업융합법학과'),
    ]),
    College('경상대학', [
      Major('경제학과'),
      Major('국제통상학과'),
    ]),
    College('경영대학', [
      Major('경영학부'),
      Major('기업경영학부'),
      Major('경영정보학부'),
      Major('KMU KIBS'),
      Major('재무금융회계학부'),
      Major('AI빅데이터융합경영학과'),
    ]),
    College('창의공과대학', [
      Major('신소재공학부'),
      Major('기계공학부'),
      Major('건설시스템공학부'),
      Major('전자공학부'),
    ]),
    College('소프트웨어융합대학', [
      Major('소프트웨어학부'),
      Major('인공지능학부'),
    ]),
    College('자동차융합대학', [
      Major('자동차공학과'),
      Major('자동차IT융합학과'),
    ]),
    College('과학기술대학', [
      Major('산림환경시스템학과'),
      Major('임산생명공학과'),
      Major('나노전자물리학과'),
      Major('응용화학부'),
      Major('식품영양학과'),
      Major('정보보안암호수학과'),
      Major('바이오발효융합학과'),
    ]),
    College('건축대학', [
      Major('건축학부'),
    ]),
    College('조형대학', [
      Major('공업디자인학과'),
      Major('시각디자인학과'),
      Major('금속공예학과'),
      Major('도자공예학과'),
      Major('의상디자인학과'),
      Major('공간디자인학과'),
      Major('영상디자인학과'),
      Major('자동차운송디자인학과'),
      Major('AI디자인학과'),
    ]),
    College('예술대학', [
      Major('음악학부'),
      Major('미술학부'),
      Major('공연예술학부'),
    ]),
    College('체육대학', [
      Major('스포츠교육학과'),
      Major('스포츠산업레저학과'),
      Major('스포츠건강재활학과'),
    ]),
    College('미래모빌리티학과', [
      Major('미래모빌리티학과'),
    ]),
    College('교양대학', [
      Major('교양대학'),
    ]),
    College('인문기술융합학부', [
      Major('인문기술융합학부'),
    ])
  ];

  static List<College> getColleges() {
    return colleges;
  }
}
