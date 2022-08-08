import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/provider/ui_provider.dart';

class NavigatorBarWidget extends StatelessWidget {
  const NavigatorBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return BottomNavigationBar(
      currentIndex: uiProvider.selectedMenuOpt,
      elevation: 0,
      onTap: (index) => uiProvider.selectedMenuOpt = index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
            // color: Colors.red,
          ),
          label: 'Mapa',
          // activeIcon:
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Dircciones',
        ),
      ],
    );
  }
}
