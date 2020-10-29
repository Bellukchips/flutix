import 'package:flutix/bloc/blocs.dart';
import 'package:flutix/bloc/videos/videos_bloc.dart';
import 'package:flutix/locale/locale.dart';
import 'package:flutix/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'shared/shared.dart';
import 'ui/page/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2C1F63),
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: AuthServices.userStream,
        ),
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionController.stream,
        )
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PageBloc(),
            ),
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(create: (_) => UserBloc()),
            BlocProvider(create: (_) => SeeMoreNpBloc()..add(FetchSeeMoreNp())),
            BlocProvider(create: (_) => SeeMoreCsBloc()..add(FetchSeeMoreCs())),
            BlocProvider(
                create: (_) => NowplayingBloc()..add(FetchNowPlaying())),
            BlocProvider(
                create: (_) => ComingsoonBloc()..add(FetchComingSoon())),
            BlocProvider(create: (_) => TicketBloc()),
            BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
            BlocProvider(create: (_) => MovieDetailBloc()),
            BlocProvider(create: (_) => CreditsBloc()),
            BlocProvider(
              create: (_) => VideosBloc(),
            ),
            BlocProvider(create: (_) => SortgenreBloc()),
            BlocProvider(create: (_) => SaveticketBloc()),
          ],
          child: BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) =>
                previousState != currentState,
            builder: (_, localeState) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (_, themeState) {
                  return MaterialApp(
                    title: "Flutix",
                    theme: themeState.themeData,
                    debugShowCheckedModeBanner: false,
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localizationsDelegates:
                        AppLocalizationsSetup.localizationDelegates,
                    localeResolutionCallback:
                        AppLocalizationsSetup.localeResolutionCallback,
                    locale: localeState.locale,
                    home: Wrapper(),
                  );
                },
              );
            },
          )),
    );
  }
}
