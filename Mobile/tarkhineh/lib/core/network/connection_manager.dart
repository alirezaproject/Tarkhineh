import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectionStatus { connected, disconnected, connecting }

class ConnectionManager extends StateNotifier<ConnectionStatus> {
  late final StreamSubscription<InternetStatus> _subscription;
  final InternetConnection _checker = InternetConnection();

  ConnectionManager() : super(ConnectionStatus.connecting) {
    _listenConnection();
    _checkInitialState();
  }

  void _listenConnection() {
    _subscription = _checker.onStatusChange.listen((status) {
      state = (status == InternetStatus.connected) ? ConnectionStatus.connected : ConnectionStatus.disconnected;
    });
  }

  Future<void> _checkInitialState() async {
    // وقتی provider اولین بار ساخته میشه، وضعیت اولیه رو بگیر
    final hasAccess = await _checker.hasInternetAccess;
    state = hasAccess ? ConnectionStatus.connected : ConnectionStatus.disconnected;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> retryCheck() async {
    state = ConnectionStatus.connecting;
    final hasAccess = await _checker.hasInternetAccess;
    state = hasAccess ? ConnectionStatus.connected : ConnectionStatus.disconnected;
  }
}

final connectionProvider = StateNotifierProvider<ConnectionManager, ConnectionStatus>((ref) => ConnectionManager());
