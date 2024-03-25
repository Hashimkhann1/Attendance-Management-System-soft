


import 'dart:async';

class SplashViewModel {

  void splashTime() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      print("Time is Done");
    });
  }

}