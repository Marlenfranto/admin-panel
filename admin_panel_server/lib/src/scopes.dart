import 'package:serverpod/serverpod.dart';

class AppScopes {
  static const admin = Scope('admin');
  static const manager = Scope('manager');
  static const user = Scope('user');
}