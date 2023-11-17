import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:linring_front_flutter/models/tagset_model.dart';
import 'package:http/http.dart' as http;
import 'package:linring_front_flutter/models/login_info.dart';
import 'package:linring_front_flutter/models/user_model.dart';
import 'package:linring_front_flutter/screens/matching_main_screen.dart';
import 'package:linring_front_flutter/widgets/custom_appbar.dart';

class MatchingLoadingScreen extends StatefulWidget {
  final LoginInfo loginInfo;
  final Tagset myTagSet;
  const MatchingLoadingScreen(
      {super.key, required this.loginInfo, required this.myTagSet});

  @override
  State<MatchingLoadingScreen> createState() => _MatchingLoadingScreenState();
}

class _MatchingLoadingScreenState extends State<MatchingLoadingScreen> {
  void _SearchUser(BuildContext context) async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url =
        Uri.parse('$apiAddress/accounts/v2/user-search/${widget.myTagSet.id}');

    final token = widget.loginInfo.access;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('Response Status Code: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      await Future.delayed(const Duration(seconds: 1));

      List<Tagset> searchTagsets =
          (json.decode(utf8.decode(response.bodyBytes)) as List)
              .map((data) => Tagset.fromJson(data))
              .toList();
      List<User> searchUsers = [];

      for (Tagset tagset in searchTagsets) {
        User? user = await _GetUser(tagset.owner);
        searchUsers.add(user!);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MatchingMainScreen(
                  loginInfo: widget.loginInfo,
                  searchTagset: searchTagsets,
                  searchUser: searchUsers,
                  myTagset: widget.myTagSet,
                )),
      );
    }
  }

  Future<User?> _GetUser(int id) async {
    String apiAddress = dotenv.get("API_ADDRESS");
    final url = Uri.parse('$apiAddress/accounts/v2/user/$id');

    final token = widget.loginInfo.access;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> userData =
          json.decode(utf8.decode(response.bodyBytes));
      User user = User.fromJson(userData);
      return user;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _SearchUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: ''),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loading_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loading.gif'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
