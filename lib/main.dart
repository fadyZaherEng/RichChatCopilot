import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/routes/routes_manager.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/app_theme.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/di/injector.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/chats/chats_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/friends_requests/friends_requests_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/login/log_in_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/main/main_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/main/main_state.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/profile/profile_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/user_info/user_info_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/friends/friends_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/restart_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RestartWidget(MyApp()));
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const RestartWidget(MyApp()),
  //   ),
  // );
}
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(create: (context) => injector()),
        BlocProvider<SettingsBloc>(create: (context) => injector()),
        BlocProvider<LogInBloc>(create: (context) => injector()),
        BlocProvider<UserInfoBloc>(create: (context) => injector()),
        BlocProvider<ChatsBloc>(create: (context) => injector()),
        BlocProvider<ProfileBloc>(create: (context) => injector()),
        BlocProvider<FriendsBloc>(create: (context) => injector()),
        BlocProvider<FriendsRequestsBloc>(create: (context) => injector()),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return  MaterialApp(
            // useInheritedMediaQuery: true,
            // builder: DevicePreview.appBuilder,
            darkTheme:AppTheme(state is GetLocalAndThemeState? state.locale.languageCode : Constants.en).light,
            navigatorKey: navigatorKey,
            navigatorObservers: [
              ChuckerFlutter.navigatorObserver,
              routeObserver,
            ],
            themeMode: ThemeMode.light,
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: RoutesManager.getRoute,
            // initialRoute: Routes.splash,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: AppTheme(state is GetLocalAndThemeState? state.locale.languageCode : Constants.en).light,
            locale: Locale(state is GetLocalAndThemeState? state.locale.languageCode : Constants.en),
             home: FriendsScreen(),
          );
        },
      ),
    );
  }
}
