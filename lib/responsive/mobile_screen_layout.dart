import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zalo_app/untils/colors.dart';
import 'package:zalo_app/untils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_rounded,
              color: (_page == 0) ? blueColor : primaryColor,
            ),
            label: 'Tin nhắn',
            backgroundColor: blueColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box_sharp,
                color: (_page == 1) ? blueColor : primaryColor,
              ),
              label: 'Danh bạ',
              backgroundColor: blueColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.apps_sharp,
                color: (_page == 2) ? blueColor : primaryColor,
              ),
              label: 'Khám phá',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer_sharp,
              color: (_page == 3) ? blueColor : primaryColor,
            ),
            label: 'Nhật kí',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2,
              color: (_page == 4) ? blueColor : secondaryColor,
            ),
            label: 'Cá nhân',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
