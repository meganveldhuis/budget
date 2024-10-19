import 'package:flutter/material.dart';

import '../pages/entry.dart';
import '../pages/settings.dart';
import '../pages/home.dart';


class SideNavBar extends StatefulWidget{
  @override
  State<SideNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SideNavBar> { //underscore at beginning of name == private class
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context){
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = SettingsPage();
        break;
      case 2:
        page = EntryPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }


    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea( //ensure it is not obscured by a hardware notch / status bar
                child:NavigationRail(
                  // extended: false, //if true, shows labels next to the icons
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home), 
                      label: Text('Home')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite), 
                      label: Text('Favourites')
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.plus_one), 
                      label: Text('Entry')
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value){
                    setState((){
                      selectedIndex = value;
                    });
                  },
                )
              ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
            ],
            ),  
        );
      }
    );
  }
}