import 'package:flutter/material.dart';
import "stateless_group.dart";
import "sateful_group.dart";
import "layout/layout.dart";
import "plugin.dart";
import "gesture.dart";
import "launcher.dart";
import "life_cycle.dart";
import "app_flutter.dart";
import "app/camera.dart";
import "route-param-receiver.dart";
import "data-return-screen.dart";
import "data-send-screen.dart";
import "network/network.dart";
import 'app/data-persistence.dart';
import "form.dart";

void main() {
  // runApp(StatelessWidgetGroup());
  runApp(DynamicTheme());
}

class DynamicTheme extends StatefulWidget {
  DynamicTheme({Key key}) : super(key: key);

  @override
  _DynamicThemeState createState() => _DynamicThemeState();
}

class _DynamicThemeState extends State<DynamicTheme> {
  Brightness bright = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo11',
      theme: ThemeData(
        // fontFamily: "FiraCode",
        primarySwatch: Colors.blue,
        brightness: bright,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("芜湖!")),
        body: Column(children: <Widget>[
          RaisedButton(
              child: Text(
                "toggle to ${bright == Brightness.light ? 'night' : 'day'} mode",
                style: TextStyle(fontFamily: "FiraCode"),
              ),
              onPressed: () {
                setState(() {
                  bright = bright == Brightness.light
                      ? Brightness.dark
                      : Brightness.light;
                });
              }),
          RouterNavigator()
        ]),
      ),
      routes: <String, WidgetBuilder>{
        // "stateless": (BuildContext context) => StatelessGroup(),
        // "stateful": (BuildContext context) => StatefulGroup(),
        "layout": (BuildContext context) => Layout(),
        "gesture": (BuildContext context) => Gesture(),
        "plugin": (BuildContext context) => ColorPlugin(),
        "launcher": (BuildContext context) => URLLauncher(),
        "lifecycle": (BuildContext context) => LifeCycle(),
        "app_lifecycle": (BuildContext context) => AppLifecycle(),
        "camera_app": (BuildContext context) => CameraApp(),
        RouterParamReceiver.routeName: (BuildContext context) =>
            RouterParamReceiver(),
        "data_return_screen": (BuildContext context) => ReturnDataHomeScreen(),
        "data_send_screen": (BuildContext context) => DataSend2NewScreen(),
        "network_demo": (BuildContext context) => NetworkDemo(),
        "form": (BuildContext context) => CustomForm()
      },
    );
  }
}

class RouterNavigator extends StatefulWidget {
  @override
  _RouterNavigatorState createState() => _RouterNavigatorState();
}

class _RouterNavigatorState extends State<RouterNavigator> {
  bool routeByName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        // 通过点击跳转或是导航
        SwitchListTile(
            title: Text('${routeByName ? '' : '不'}通过路由名跳转'),
            value: routeByName,
            onChanged: (bool value) {
              setState(() {
                routeByName = value;
              });
            }),
        // _item("Less Widget", StatelessGroup(), "stateless"),
        // _item("Ful Widget", StatefulGroup(), "stateful"),
        // _item("Layout Widget", Layout(), "layout"),
        // _item("Gesture Widget", Gesture(), "gesture"),
        // _item("Plugin Widget", ColorPlugin(), "plugin"),
        // _item("Launcher Widget", URLLauncher(), "launcher"),
        // _item("LifeCycle Widget", LifeCycle(), "life cycle"),
        // _item("App LifeCycle Widget", AppLifecycle(), "app life cycle"),
        // _item("Camera App", CameraApp(), "czamera_app"),
        // _item(
        //     "Route Param Receiver",
        //     RouterParamReceiver(),
        //     RouterParamReceiver.routeName,
        //     ScreenArgs("SEND TITLE", "SEND MESSAGE")),
        // _item("Data Return To Home Screen", ReturnDataHomeScreen(),
        //     "data_return_screen"),
        // _item("Data Send To New Screen", DataSend2NewScreen(),
        //     "data_send_screen"),
        // _item("Network Demo", NetworkDemo(), "network_demo"),
        _item("Form Demo", CustomForm(), "form"),
        Image(
            width: 100,
            height: 100,
            image: AssetImage("./assets/images/48507806.png"))
      ]),
    );
  }

  _item(String title, Widget page, String route, [ScreenArgs args]) {
    return Container(
        child: RaisedButton(
            onPressed: () {
              if (routeByName) {
                Navigator.pushNamed(context, route, arguments: args);
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page));
              }
            },
            child: Text(title)));
  }
}