import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import './app_localizations.dart';
import './blocs/current_local.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentLocal()),
      ],
      child: Consumer<CurrentLocal>(builder: (context, currentLocal, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          supportedLocales: [
            Locale('en', 'US'),
            Locale('bn', 'BD'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
          home: MyDemoWidget(),
          locale: currentLocal.local,
        );
      }),
    );
  }
}

class MyDemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('title_string')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('taka_string'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final CurrentLocal _curLocal =
              Provider.of<CurrentLocal>(context, listen: false);
          if (_curLocal.local.languageCode == "bn") {
            _curLocal.changeLanguageToEnglish();
          } else {
            _curLocal.changeLanguageToBengali();
          }
        },
        child: Icon(Icons.language),
        backgroundColor: Colors.green,
      ),
    );
  }
}