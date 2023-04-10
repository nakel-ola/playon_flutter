import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  double _scrollOffset = 0.0;
  String _active = "Movies";

  double get scrollOffset => _scrollOffset;

  List<String> get menuItems => ["Home", "Movies", "Series"];
  String get activeMenu => _active;

  void updateOffset(double value) {
    _scrollOffset = value;
    notifyListeners();
  }

  updateActive(String value) {
    _active = value;
    notifyListeners();
  }

  void initailize() {}
}
