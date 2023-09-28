import 'package:flutter/material.dart';

final _controller = PageController(initialPage: 0);
List<bool> _selected = [true, false];
List<Color> _borderColors = [const Color(0xff1c1c1c), Colors.transparent];

class TagShowScreen extends StatefulWidget {
  const TagShowScreen({super.key});

  @override
  State createState() => _TagShowScreenState();
}

class _TagShowScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ToggleButtons(
            onPressed: (int index) {
              setState(() {
                if (index == 1) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                } else {
                  _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
                for (int i = 0; i < _selected.length; i++) {
                  _selected[i] = i == index;
                }
                // 선택된 Button의 border bottom 색상 변경
                _updateBorderColors();
              });
            },
            renderBorder: false,
            fillColor: Colors.transparent,
            color: const Color(0xff6c5916),
            selectedColor: const Color(0xff1c1c1c),
            borderColor: Colors.transparent,
            isSelected: _selected,
            children: const <Widget>[
              SizedBox(
                width: 210,
                child: Center(
                  child: Text(
                    '활성화',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(
                width: 210,
                child: Center(
                  child: Text(
                    '비활성화',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            children: const [
              TagActive(),
              TagInactive(),
            ],
            onPageChanged: (index) {
              setState(() {
                for (int i = 0; i < _selected.length; i++) {
                  _selected[i] = i == index;
                }
                // Screen 변경 시, 하단 테두리 색상 변경
                _updateBorderColors();
              });
            },
          ),
        ),
      ],
    );
  }

  void _updateBorderColors() {
    // border bottom 색상 초기화
    _borderColors = [Colors.transparent, Colors.transparent];
    // 선택된 버튼에 border bottom 색상 부여
    for (int i = 0; i < _selected.length; i++) {
      if (_selected[i]) {
        _borderColors[i] = const Color(0xff1c1c1c);
      }
    }
  }
}

class TagActive extends StatelessWidget {
  const TagActive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("활성화"),
    );
  }
}

class TagInactive extends StatelessWidget {
  const TagInactive({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("비활성화"),
    );
  }
}
