import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/widgets/landing_page/tab_buttons.dart';
import 'package:movie_app/widgets/landing_page/tab_page.dart';

//stateful widget for tab bar animation
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
//tabcontroller to control tabbar
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: kBodyColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(0.4),
                    Colors.pink.withOpacity(0.4)
                  ]),
                ),
                child: Container(),
              ),
              ListTile(
                title: Text(
                  'Movies',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.movie,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'TV Shows',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.tv,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Discover',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.chair,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Popular People',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Reminders',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.alarm,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Contact Developers',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.developer_board,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Google+ Community',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Unlock Pro',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.lock_open,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kBodyColor,
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.search),
          )
        ],
        backgroundColor: Colors.black,
        title: const Text("Movie App"),
      ),
      body: Column(children: [
        //tabButtons to control tabbar
        TabButtons(tabController: _tabController),
        // tab bar view here
        Expanded(child: TabPage(tabController: _tabController)),
      ]),
    );
  }
}
