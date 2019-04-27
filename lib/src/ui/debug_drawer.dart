import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'debug_drawer_theme.dart';

class DebugDrawerBuilder {
  static TransitionBuilder build({
    List<DebugDrawerModule> modules = const [],
    DebugDrawerTheme theme,
  }) {
    return (BuildContext context, Widget widget) =>
        DebugDrawer(
          child: widget,
          modules: modules,
          theme: theme ?? DebugDrawerTheme.defaultTheme,
        );
  }
}

class DebugDrawer extends StatelessWidget {
  final Widget child;

  final DebugDrawerTheme theme;

  final List<Widget> modules;

  DebugDrawer({
    Key key,
    this.child,
    this.modules = const [],
    this.theme,
  }) : super(key: key);

  static DebugDrawer of(BuildContext context) {
    return context.ancestorWidgetOfExactType(DebugDrawer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: child,
      endDrawer: Container(
        padding: EdgeInsets.fromLTRB(16, MediaQuery
            .of(context)
            .padding
            .top, 16,
            MediaQuery
                .of(context)
                .padding
                .bottom),
        color: theme.backgroundColor,
        width: theme.width,
        child: ListView(
          children: modules,
        ),
      ),
    );
  }
}

class DebugDrawerModule extends StatelessWidget {
  DebugDrawerModule({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    DebugDrawerTheme theme = DebugDrawer
        .of(context)
        .theme;
    return Padding(
      padding: theme.sectionMargin,
      child: Container(
        padding: theme.sectionPadding,
        color: theme.sectionColor,
        child: child,
      ),
    );
  }
}

class PlatformModule extends DebugDrawerModule {
  @override
  Widget build(BuildContext context) {
    return DebugDrawerModule(
      child: Column(
        children: [
          DebugDrawerField(label: "OS", value: "${Platform.operatingSystem}"),
          DebugDrawerField(
              label: "OS Version", value: "${Platform.operatingSystemVersion}"),
          DebugDrawerField(
              label: "Isolate script", value: "${Platform.script.toString()}"),
          DebugDrawerField(
              label: "Path separator", value: "${Platform.pathSeparator}"),
          DebugDrawerField(
              label: "Locale name", value: "${Platform.localeName}"),
          DebugDrawerField(
              label: "Local hostname", value: "${Platform.localHostname}"),
          DebugDrawerField(
              label: "Processors", value: "${Platform.numberOfProcessors}"),
        ],
      ),
    );
  }
}

class MediaQueryModule extends DebugDrawerModule {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return DebugDrawerModule(
      child: Column(
        children: [
          DebugDrawerField(
              label: "PixelRatio", value: "${mediaQuery.devicePixelRatio}"),
          DebugDrawerField(
              label: "Accesible Navigation",
              value: "${mediaQuery.accessibleNavigation}"),
          DebugDrawerField(
              label: "Always use 24 hour format",
              value: "${mediaQuery.alwaysUse24HourFormat}"),
          DebugDrawerField(label: "Bold text", value: "${mediaQuery.boldText}"),
          DebugDrawerField(
              label: "PixelRatio", value: "${mediaQuery.disableAnimations}"),
          DebugDrawerField(
              label: "InvertColors", value: "${mediaQuery.invertColors}"),
          DebugDrawerField(
              label: "Orientation",
              value: "${mediaQuery.orientation.toString()}"),
          DebugDrawerField(
              label: "Platform Brightness",
              value: "${mediaQuery.platformBrightness}"),
          DebugDrawerField(
              label: "Text scale factor",
              value: "${mediaQuery.textScaleFactor}"),
          DebugDrawerField(
              label: "PixelRatio", value: "${mediaQuery.textScaleFactor}"),
        ],
      ),
    );
  }
}

class DebugDrawerField extends StatelessWidget {
  final String label;
  final String value;

  DebugDrawerField({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebugDrawerTheme theme = DebugDrawer
        .of(context)
        .theme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(right: 8),
              width: 100,
              child: Text(
                label,
                style: theme.labelStyle,
              )),
          Expanded(
            child: Text(
              value,
              style: theme.valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}