import 'package:get_it/get_it.dart';
import 'package:rich_chat_copilot/lib/src/di/bloc_injector.dart';
import 'package:rich_chat_copilot/lib/src/di/data_layer_injector.dart';
import 'package:rich_chat_copilot/lib/src/di/repository_injector.dart';
import 'package:rich_chat_copilot/lib/src/di/use_case_injector.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await initializeDataDependencies();
  await initializeRepositoryDependencies();
  await initializeUseCaseDependencies();
  await initializeBlocDependencies();
}
