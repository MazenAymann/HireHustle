class Statics{
  static var isDarkMode = true;
  static var darkModeBackground = 'assets/images/main_background.png';
  static var lightModeBackground = 'assets/images/main_background_light.png';

  static String background(){
    if(isDarkMode) {
      return darkModeBackground;
    }
    return lightModeBackground;
  }
}
