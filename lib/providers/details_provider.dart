import 'package:flutter/material.dart';

import '../models/models.dart';

class DetailsProvider extends ChangeNotifier {
  Video? _video;

  Video? get video => _video;

  addVideo(Video video) {
    _video = video;
    notifyListeners();
  }

  removeVideo(Video video) {
    _video = null;
  }
}
