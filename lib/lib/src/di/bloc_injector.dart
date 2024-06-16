import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/login/log_in_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/main/main_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/user_info/user_info_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<MainCubit>(() => MainCubit(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<SettingsBloc>(() => SettingsBloc(
        injector(),
        injector(),
      ));
  injector.registerFactory<LogInBloc>(() => LogInBloc());
  injector.registerFactory<UserInfoBloc>(() => UserInfoBloc());
}
