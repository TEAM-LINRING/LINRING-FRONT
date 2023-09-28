import 'package:flutter/material.dart';

final _controller = PageController(initialPage: 0);
List<bool> _selected = [true, false];

class TagShowScreen extends StatefulWidget {
  const TagShowScreen({Key? key}) : super(key: key);

  @override
  State createState() => _TagShowScreenState();
}

class _TagShowScreenState extends State<TagShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabItem(0, '활성화'),
              _buildTabItem(1, '비활성화'),
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
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(int index, String label) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
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
        });
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _selected[index]
                  ? const Color(0xff41350a).withOpacity(0.62)
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: _selected[index]
                  ? const Color(0xff1c1c1c)
                  : const Color(0xff6c5916),
            ),
          ),
        ),
      ),
    );
  }
}

class TagActive extends StatelessWidget {
  const TagActive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("활성화"),
    );
  }
}

class TagInactive extends StatelessWidget {
  const TagInactive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("비활성화"),
    );
  }
}
