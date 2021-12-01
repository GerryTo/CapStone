import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt _instance = GetIt.instance;
  static GetIt get getIt => _instance;
  static void registerServices() {
    _instance.registerSingleton<CurrentUserInfo>(CurrentUserInfo());
  }
}
