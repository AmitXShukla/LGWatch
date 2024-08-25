import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../shared/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import './aboutus.dart';
import './community.dart';
import './settings.dart';
import './signin.dart';
import './signup.dart';
import './media.dart';
import './history.dart';
import './devices.dart';
import './device.dart';
import './alert.dart';
import './alertc.dart';
import './prompt.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  // Locale _locale = "en" as Locale;
  Locale _locale = const Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(useMaterial3: true),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      themeMode: themeMode,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.light(),
      home: NavRailExample(
          handleBrightnessChange: handleBrightnessChange, setLocale: setLocale),
      routes: {
        // '/': (context) => const LogIn(), //- can not set if home: ERPHomePage() is setup, only works with initiated route
        // AboutUs.routeName: (context) => AboutUs(),
        Community.routeName: (context) => Community(),
        Settings.routeName: (context) => Settings(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        Media.routeName: (context) => Media(),
        History.routeName: (context) => History(),
        Devices.routeName: (context) => Devices(),
        Device.routeName: (context) => Device(),
        Alert.routeName: (context) => Alert(),
        CAlert.routeName: (context) => CAlert(),
        Prompt.routeName: (context) => Prompt(),
      },
    );
  }
}

class NavRailExample extends StatefulWidget {
  NavRailExample(
      {super.key,
      required this.handleBrightnessChange,
      required this.setLocale});
  Function(bool useLightMode) handleBrightnessChange;
  Function(Locale _locale) setLocale;

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  // NavigationRailLabelType labelType = NavigationRailLabelType.all;
  NavigationRailLabelType labelType = NavigationRailLabelType.selected;
  bool showLeading = true;
  bool showTrailing = true;
  bool isBright = false;
  // double groupAlignment = -1.0;
  double groupAlignment = 0.0;
  static List<String> lang = <String>['en', 'es'];
  String dropdownValue = lang.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: labelType,
              leading: showLeading
                  ? FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.blueAccent,
                      // shape: ShapeBorder.lerp(10, b, t),
                      elevation: 0.0,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/',
                        );
                      },
                      child: const Icon(Icons.question_answer,
                          color: Colors.deepOrangeAccent),
                    )
                  : const SizedBox(),
              trailing: showTrailing
                  ? IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/signin',
                        );
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    )
                  : const SizedBox(),
              destinations: <NavigationRailDestination>[
                // NavigationRailDestination(
                //   icon: Icon(Icons.favorite_border),
                //   selectedIcon: Icon(Icons.favorite),
                //   label: Text('First'),
                // ),
                NavigationRailDestination(
                  icon: Badge(child: 
                  GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/alert',
                        );
                      },
                    child: const Icon(Icons.personal_video))
                  ),
                  selectedIcon:
                      Badge(child: 
                      GestureDetector(
                        onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/alert',
                        );
                      },
                        child: Icon(Icons.personal_video_rounded))),
                  // label: Text('personal')
                  label: Text(AppLocalizations.of(context)!.cMenu3),
                ),
                NavigationRailDestination(
                  icon: Badge(child: 
                  GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/calert',
                        );
                      },
                    child: const Icon(Icons.holiday_village))),
                  selectedIcon:
                      Badge(child: 
                      GestureDetector(
                        onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/calert',
                        );
                      },
                        child: const Icon(Icons.holiday_village_rounded))),
                  label: Text(AppLocalizations.of(context)!.cMenu9),
                ),
                NavigationRailDestination(
                  icon: Badge(child: 
                  GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/alert',
                        );
                      },
                    child: const Icon(Icons.history))),
                  selectedIcon: Badge(child: 
                  GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/alert',
                        );
                      },
                    child: const Icon(Icons.save))),
                  label: Text(AppLocalizations.of(context)!.cMenu5),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/devices',
                        );
                      },
                    child: const Icon(Icons.devices)),
                  selectedIcon: const Icon(Icons.devices_rounded),
                  label: Text(AppLocalizations.of(context)!.cMenu10),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/community',
                        );
                      },
                    child: const Icon(Icons.gps_fixed)),
                  selectedIcon: GestureDetector(
                    onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/community',
                        );
                      },
                      child: const Icon(Icons.gps_fixed_rounded)),
                  label: Text(AppLocalizations.of(context)!.cMenu9),
                ),
                NavigationRailDestination(
                  icon: GestureDetector(
                      onTap: () =>
                          {widget.handleBrightnessChange(isBright = !isBright)},
                      child: const Icon(Icons.brightness_2_outlined)),
                  selectedIcon:
                      GestureDetector(
                        onTap: () =>
                          {widget.handleBrightnessChange(isBright = !isBright)},
                        child: const Icon(Icons.brightness_2_outlined)),
                  label: Text(AppLocalizations.of(context)!.cMenu11),
                ),
                NavigationRailDestination(
                    icon: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      // style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                          switch (value) {
                            // Your Enum Value which you have passed
                            case "en":
                              widget.setLocale(
                                  const Locale.fromSubtags(languageCode: 'en'));
                              break;
                            case "es":
                              widget.setLocale(
                                  const Locale.fromSubtags(languageCode: 'es'));
                              break;
                          }
                        });
                      },
                      items: lang.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    label: Text(AppLocalizations.of(context)!.cMenu12))
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
              child: Prompt(),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text('selectedIndex: $_selectedIndex'),
              //     const SizedBox(height: 20),
              //     Text('Label type: ${labelType.name}'),
              //     const SizedBox(height: 10),
              //     OverflowBar(
              //       spacing: 10.0,
              //       children: <Widget>[
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               labelType = NavigationRailLabelType.none;
              //             });
              //           },
              //           child: const Text('None'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               labelType = NavigationRailLabelType.selected;
              //             });
              //           },
              //           child: const Text('Selected'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               labelType = NavigationRailLabelType.all;
              //             });
              //           },
              //           child: const Text('All'),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 20),
              //     Text('Group alignment: $groupAlignment'),
              //     const SizedBox(height: 10),
              //     OverflowBar(
              //       spacing: 10.0,
              //       children: <Widget>[
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               groupAlignment = -1.0;
              //             });
              //           },
              //           child: const Text('Top'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               groupAlignment = 0.0;
              //             });
              //           },
              //           child: const Text('Center'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               groupAlignment = 1.0;
              //             });
              //           },
              //           child: const Text('Bottom'),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 20),
              //     OverflowBar(
              //       spacing: 10.0,
              //       children: <Widget>[
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               showLeading = !showLeading;
              //             });
              //           },
              //           child:
              //               Text(showLeading ? 'Hide Leading' : 'Show Leading'),
              //         ),
              //         ElevatedButton(
              //           onPressed: () {
              //             setState(() {
              //               showTrailing = !showTrailing;
              //             });
              //           },
              //           child: Text(
              //               showTrailing ? 'Hide Trailing' : 'Show Trailing'),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class BottomAppBar extends StatefulWidget {
//   BottomAppBar(
//       {super.key,
//       required this.isElevated,
//       required this.isVisible,
//       required this.handleBrightnessChange,
//       required this.setLocale});

//   bool isElevated;
//   bool isVisible;
//   Function(bool useLightMode) handleBrightnessChange;
//   Function(Locale _locale) setLocale;
//   @override
//   BottomAppBarState createState() => BottomAppBarState();
// }

// class BottomAppBarState extends State<BottomAppBar> {
//   bool isBright = true;
//   /* static List<String> lang = <String>['english', 'español', '中国人', 'हिंदी']; */
//   static List<String> lang = <String>['english', 'español'];
//   String dropdownValue = lang.first;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 100),
//       height: widget.isVisible ? 80.0 : 0,
//       child: Row(
//         children: <Widget>[
//           PopupMenuButton<Menu>(
//             // popUpAnimationStyle: AnimationStyle(
//             //   curve: Easing.emphasizedDecelerate,
//             //   duration: const Duration(seconds: 1),
//             // ),
//             icon: const Icon(
//               Icons.more_vert,
//               color: Colors.blueGrey,
//             ),
//             onSelected: (Menu item) {},
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
//               PopupMenuItem<Menu>(
//                 value: Menu.preview,
//                 child: ListTile(
//                   leading: Icon(Icons.book_online_rounded),
//                   title: Text(cHistory),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/history',
//                     );
//                   },
//                 ),
//               ),
//               PopupMenuItem<Menu>(
//                 value: Menu.share,
//                 child: ListTile(
//                   leading: Icon(Icons.photo),
//                   title: Text(cMedia),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/media',
//                     );
//                   },
//                 ),
//               ),
//               PopupMenuItem<Menu>(
//                 value: Menu.getLink,
//                 child: ListTile(
//                   leading: Icon(Icons.location_city),
//                   title: Text(cCommunity),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/community',
//                     );
//                   },
//                 ),
//               ),
//               PopupMenuItem<Menu>(
//                 value: Menu.getLink,
//                 child: ListTile(
//                   leading: Icon(Icons.device_hub),
//                   title: Text(cDevices),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/devices',
//                     );
//                   },
//                 ),
//               ),
//               const PopupMenuDivider(),
//               PopupMenuItem<Menu>(
//                 value: Menu.remove,
//                 child: const ListTile(
//                   leading: Icon(Icons.dark_mode),
//                   title: Text(cDarkMode),
//                 ),
//                 onTap: () {
//                   isBright = !isBright;
//                   widget.handleBrightnessChange(isBright);
//                 },
//               ),
//               PopupMenuItem<Menu>(
//                 value: Menu.download,
//                 child: ListTile(
//                   leading: const Icon(Icons.language),
//                   // title: Text(cLanguage),
//                   subtitle: DropdownButton<String>(
//                     value: dropdownValue,
//                     icon: const Icon(Icons.arrow_downward),
//                     elevation: 16,
//                     // style: const TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                     onChanged: (String? value) {
//                       // This is called when the user selects an item.
//                       setState(() {
//                         dropdownValue = value!;
//                         switch (value) {
//                           // Your Enum Value which you have passed
//                           case "english":
//                             widget.setLocale(
//                                 const Locale.fromSubtags(languageCode: 'en'));
//                             break;
//                           case "español":
//                             widget.setLocale(
//                                 const Locale.fromSubtags(languageCode: 'es'));
//                             break;
//                           case "中国人":
//                             widget.setLocale(
//                                 const Locale.fromSubtags(languageCode: 'zh'));
//                             break;
//                           case "हिंदी":
//                             widget.setLocale(
//                                 const Locale.fromSubtags(languageCode: 'hi'));
//                             break;
//                         }
//                       });
//                     },
//                     items: lang.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               PopupMenuItem<Menu>(
//                 value: Menu.download,
//                 child: ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const Text(cSettings),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/settings',
//                     );
//                   },
//                 ),
//               ),
//               const PopupMenuDivider(),
//               PopupMenuItem<Menu>(
//                 value: Menu.download,
//                 child: ListTile(
//                   leading: Icon(Icons.login),
//                   title: Text(cSignIn),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/signin',
//                     );
//                   },
//                 ),
//               ),
//               const PopupMenuDivider(),
//               PopupMenuItem<Menu>(
//                 value: Menu.download,
//                 child: ListTile(
//                   leading: const Icon(Icons.info),
//                   title: const Text(cAboutUs),
//                   onTap: () => {
//                     Navigator.pushNamed(
//                       context,
//                       '/aboutus',
//                     )
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Badge(
//             label: Text("3"),
//             child: IconButton(
//               tooltip: cPersonal,
//               icon: const Icon(
//                 Icons.home_max_sharp,
//                 color: Colors.deepOrangeAccent,
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/alert',
//                 );
//               },
//             ),
//           ),
//           Badge(
//             label: Text("0"),
//             child: IconButton(
//               tooltip: cCommunity,
//               icon: const Icon(
//                 Icons.notifications_active,
//                 color: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/alert',
//                 );
//               },
//             ),
//           ),
//           IconButton(
//             tooltip: cSearch,
//             icon: const Icon(Icons.snooze_outlined),
//             onPressed: () {
//               Navigator.pushNamed(
//                   context,
//                   '/alert',
//                 );
//             },
//           ),
//           IconButton(
//             tooltip: cBookmark,
//             icon: const Icon(Icons.bookmarks),
//             onPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 '/alert',
//               );
//             },
//           ),
//           Row(
//             children: [
//               // const Icon(
//               //   Icons.wind_power,
//               //   color: Colors.blueGrey,
//               // ),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 // AppLocalizations.of(context)!.cAppTitle,
//                 "Test",
//                 style: cHeaderText,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               FloatingActionButton(
//                 mini: true,
//                 onPressed: () => {
//                   Navigator.pushNamed(
//                     context,
//                     '/prompt',
//                   )
//                 },
//                 tooltip: "Gemini",
//                 elevation: 0.0,
//                 child: const Icon(Icons.question_answer),
//               )
//             ],
//           ),
//         ],
//       ),
//       // ),
//     );
//   }
// }