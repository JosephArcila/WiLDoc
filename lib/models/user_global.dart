class UserGlobal {
  static final UserGlobal _singleton = UserGlobal._internal();

  factory UserGlobal() {
    return _singleton;
  }

  UserGlobal._internal(); // provide internal constructor

  String? userId = null;  // member to hold user id
}