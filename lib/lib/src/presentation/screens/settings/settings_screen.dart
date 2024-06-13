import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/core/utils/constants.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/get_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/domain/usecase/set_theme_use_case.dart';
import 'package:rich_chat_copilot/lib/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/custom_switch_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/widgets/restart_widget.dart';

class SettingsScreen extends BaseStatefulWidget {
  const SettingsScreen({super.key});

  @override
  BaseState<SettingsScreen> baseCreateState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  bool isDarkMode = false;

  SettingsBloc get _bloc => BlocProvider.of<SettingsBloc>(context);

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isDarkMode = GetThemeUseCase(injector())();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
      if (state is ChangeThemeEvent) {
        RestartWidget.restartApp(context);
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "settingsTitle",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomSwitchWidget(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    _bloc.add(ChangeThemeEvent(isDarkTheme: value));
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  title: "Theme",
                ),
              ],
            ),
          ));
    });
  }
}
