import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  final GetIt _instance = GetIt.instance;
  GetIt get instance => _instance;
  void registerServices() {
    _instance.registerSingleton<CurrentUserInfo>(CurrentUserInfo());
  }
}
