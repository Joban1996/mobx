import 'package:flutter/material.dart';






class DashboardProvider with ChangeNotifier{

  int selectedIndex = 0;

  setSelectedIndex(int index)
  {
    selectedIndex = index;
    notifyListeners();
  }


}