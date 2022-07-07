import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hackernewsfschmtz/pages/article_list.dart';

import '../controller/bottom_navigation_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showBottomBar = true;

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  List<Widget> _articlesList = [
    ArticleList(
      key: UniqueKey(),
      page: 'topstories',
    ),
    ArticleList(
      key: UniqueKey(),
      page: 'newstories',
    ),
    ArticleList(
      key: UniqueKey(),
      page: 'beststories',
    ),
    ArticleList(
      key: UniqueKey(),
      page: 'showstories',
    ),
    ArticleList(
      key: UniqueKey(),
      page: 'askstories',
    )
  ].obs;

  void refreshHome() {
    _articlesList = [
      ArticleList(
        key: UniqueKey(),
        page: 'topstories',
      ),
      ArticleList(
        key: UniqueKey(),
        page: 'newstories',
      ),
      ArticleList(
        key: UniqueKey(),
        page: 'beststories',
      ),
      ArticleList(
        key: UniqueKey(),
        page: 'showstories',
      ),
      ArticleList(
        key: UniqueKey(),
        page: 'askstories',
      )
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() => _showBottomBar = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              setState(() => _showBottomBar = false);
            }
            return true;
          },
          child: Obx(() => SafeArea(
              child: _articlesList[
                  bottomNavigationController.currentIndex.value]))),
      bottomNavigationBar: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: (_showBottomBar) ? 1 : 0,
          child: (_showBottomBar)
              ? Obx(
                  () => NavigationBar(
                    labelBehavior:
                        NavigationDestinationLabelBehavior.onlyShowSelected,
                    selectedIndex:
                        bottomNavigationController.currentIndex.value,
                    onDestinationSelected: (index) {
                      bottomNavigationController.changeIndex(index);

                      //Refresh page if same index
                      if (index ==
                          bottomNavigationController.currentIndex.value) {
                        refreshHome();
                      }
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.bar_chart_outlined),
                        selectedIcon: Icon(Icons.bar_chart),
                        label: 'Top',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.schedule_outlined),
                        selectedIcon: Icon(Icons.schedule),
                        label: 'New',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.star_outline),
                        selectedIcon: Icon(Icons.star),
                        label: 'Best',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.campaign_outlined),
                        selectedIcon: Icon(Icons.campaign),
                        label: 'Show',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.contact_support_outlined),
                        selectedIcon: Icon(Icons.contact_support),
                        label: 'Ask',
                      ),
                    ],
                  ),
                )
              : null),
    );
  }
}
