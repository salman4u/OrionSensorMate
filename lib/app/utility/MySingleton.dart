class MySingleton {
  // Private constructor
  MySingleton._privateConstructor();

  // The singleton instance
  static final MySingleton _instance = MySingleton._privateConstructor();

  // Getter to access the instance
  static MySingleton get instance => _instance;

  // The text value that needs to be accessed globally
  static String text = "Salman";
}