import "package:flutter/material.dart";

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
  const Choice(title: 'ANDROID', icon: Icons.android),
];

class TopNavigationView extends StatelessWidget {
  const TopNavigationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: choices.length,
            initialIndex: 0,
            child: Scaffold(
                appBar: AppBar(
                    title: const Text("Tabbed AppBar"),
                    bottom: TabBar(
                        isScrollable: true,
                        tabs: choices
                            .map((Choice choice) => Tab(
                                text: choice.title, icon: Icon(choice.icon)))
                            .toList())),
                body: TabBarView(
                  children: choices
                      .map((Choice choice) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ChoiceCard(choice: choice)))
                      .toList(),
                ))));
  }
}

class ChoiceCard extends StatelessWidget {
  final Choice choice;

  const ChoiceCard({Key key, @required this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;

    return Card(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle)
          ],
        )));
  }
}

class BotNavigationView extends StatefulWidget {
  BotNavigationView({Key key}) : super(key: key);

  @override
  _BotNavigationViewState createState() => _BotNavigationViewState();
}

class _BotNavigationViewState extends State<BotNavigationView>
    with SingleTickerProviderStateMixin {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  int _idx = 0;

  PageController _controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 用于页面间滚动的widget
      body: PageView(
        pageSnapping: false,
        reverse: false,
        onPageChanged: (int i) {
          print(i);
        },
        controller: _controller,
        children: <Widget>[
          Text("1"),
          Text("2"),
          Text("3"),
          Text("4"),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _idx,
          onTap: (int i) {
            _controller.jumpToPage(i);
            setState(() {
              _idx = i;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _buildItem(Icons.home, "首页", 0),
            _buildItem(Icons.search, "搜索", 1),
            _buildItem(Icons.camera_alt, "旅拍", 2),
            _buildItem(Icons.account_circle, "我的", 3),
          ]),
    );
  }

  BottomNavigationBarItem _buildItem(
    IconData defaultIcon,
    String title,
    int idx,
  ) {
    return BottomNavigationBarItem(
        icon: Icon(defaultIcon, color: _defaultColor, size: 28.0),
        activeIcon: Icon(defaultIcon, color: _activeColor),
        label: title ?? "");
  }
}

class SideNavigationView extends StatefulWidget {
  SideNavigationView({Key key}) : super(key: key);

  @override
  _SideNavigationViewState createState() => _SideNavigationViewState();
}

class _SideNavigationViewState extends State<SideNavigationView> {
  String _curr = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Side Navigation")),
      body: Center(child: Text("Current Chosed $_curr")),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            duration: const Duration(milliseconds: 300),
            child: const Text(
              "Side Menu",
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            )),
        ListTile(
          leading: Icon(Icons.file_download),
          title: Text('Item 1'),
          onTap: () {
            setState(() {
              _curr = "1";
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.file_upload),
          title: Text('Item 2'),
          onTap: () {
            setState(() {
              _curr = "2";
            });
            Navigator.pop(context);
          },
        ),
      ])),
    );
  }
}
