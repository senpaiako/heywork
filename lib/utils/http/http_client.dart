class ServerUtilities {
  // static String get http =>
  //     const String.fromEnvironment('HTTP', defaultValue: 'http://');
  // static String get host =>
  //     const String.fromEnvironment('HOST', defaultValue: 'localhost');
  // static String get port =>
  //     const String.fromEnvironment('PORT', defaultValue: ':7778');

  static String get http =>
      const String.fromEnvironment('HTTP', defaultValue: 'https://');
  static String get host =>
      const String.fromEnvironment('HOST', defaultValue: 'payroll.vade.dev');
  static String get port =>
      const String.fromEnvironment('PORT', defaultValue: '');

  static String get server {
    if (port.isEmpty) {
      return '$http$host';
    }
    return '$http$host$port';
  }

  static String get baseUrl => '$http$host ';
  static String get imageServer => '$http$host images/';
  static String get assetsServer => '$http$host assets/';
  static String get videoServer => '$http$host videos/';
}
