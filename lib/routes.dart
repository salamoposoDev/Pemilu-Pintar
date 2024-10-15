import 'package:flutter/material.dart';
import 'package:pemilu_pintar/screens/dashboard/dashboard.dart';

final Map<String, WidgetBuilder> routes = {
  DashboardPage.routeName: (context) => const DashboardPage(
        email: '',
      ),
};
