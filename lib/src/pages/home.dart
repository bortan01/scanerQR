import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/provider/scan_provider.dart';
import 'package:scaner_qr/src/provider/ui_provider.dart';
import 'package:scaner_qr/src/widget/directions_widget.dart';
import 'package:scaner_qr/src/widget/flotting_botton_widget.dart';
import 'package:scaner_qr/src/widget/history_maps_widget.dart';
import 'package:scaner_qr/src/widget/navigator_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () async {
                final scanProvider =
                    Provider.of<ScanProvider>(context, listen: false);
                await scanProvider.borrarTodos();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const NavigatorBarWidget(),
      floatingActionButton: const FloatingBottonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    switch (uiProvider.selectedMenuOpt) {
      case 0:
        scanProvider.cargarScansByType('geo');
        return const HistoryMapsWidget();
      case 1:
        scanProvider.cargarScansByType('http');
        return const DirectionsWidget();
      default:
        scanProvider.cargarScansByType('http');
        return const HistoryMapsWidget();
    }
  }
}
