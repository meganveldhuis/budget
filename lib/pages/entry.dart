import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
import '../my_app_state.dart';




class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); //track changes to app's current state
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }


    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCardWidget(pair: pair),
            SizedBox(height: 10),
            Row(
             mainAxisSize: MainAxisSize.min, //dont take all available horizontal space
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width:10),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
    );
  }
}


class BigCardWidget extends StatelessWidget {
  const BigCardWidget({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          pair.asCamelCase, 
          style:style,
          semanticsLabel: "${pair.first} ${pair.second}",  //helps accessibility
        ),
      ),
    );
  }
}