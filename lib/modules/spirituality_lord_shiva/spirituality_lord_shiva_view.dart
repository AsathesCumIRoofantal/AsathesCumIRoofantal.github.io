import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'spirituality_lord_shiva_controller.dart';

class SpiritualityLordShivaView extends GetView<SpiritualityLordShivaController> {
  const SpiritualityLordShivaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text('SpiritualityLordShiva'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
                : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text('SpiritualityLordShiva is working'),
          ),
        ),
      ),
    );
  }
}
