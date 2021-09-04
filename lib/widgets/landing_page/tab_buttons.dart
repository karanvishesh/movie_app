import 'package:flutter/material.dart';

class TabButtons extends StatelessWidget {
  const TabButtons({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: TabBar(
        unselectedLabelColor: Colors.white60,
        controller: _tabController,
        indicatorColor: Colors.green,
        indicatorWeight: 5,
        labelStyle: TextStyle(fontSize: 18),
        tabs: [
          Tab(
            text: 'Popular',
          ),
          Tab(
            text: 'Top-Rated',
          ),
          Tab(
            text: 'Upcoming',
          ),
        ],
      ),
    );
  }
}
