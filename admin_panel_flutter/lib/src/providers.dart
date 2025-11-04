import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// 1. Provider for the Serverpod Client
// Creates a singleton instance of the client, configured for the local server.
final clientProvider = Provider<Client>((ref) {
  return Client(
    'http://localhost:8080/', // Your server's address
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  )..connectivityMonitor = FlutterConnectivityMonitor();
});

// 2. Provider for the SessionManager
// Manages the user's session and authentication state.
final sessionManagerProvider = Provider<SessionManager>((ref) {
  return SessionManager(
    caller: ref.watch(clientProvider).modules.auth,
  )..initialize();
});

// 3. StateNotifier for Authentication State
// A custom class to hold the user's authentication information.
class AuthState {
  final UserInfo? userInfo;
  final AppUser? appUser;

  AuthState({this.userInfo, this.appUser});

  bool get isSignedIn => userInfo != null;
}

// Notifier to manage changes in authentication state.
class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  AuthNotifier(this.ref) : super(AuthState()) {
    _initialize();
  }

  // Initialize the notifier by listening to the session manager.
  void _initialize() async {
    final sessionManager = ref.read(sessionManagerProvider);
    
    // Set initial state
    state = AuthState(
      userInfo: sessionManager.signedInUser,
      appUser: sessionManager.signedInUser != null ? await _fetchAppUser() : null,
    );

    // Listen for changes in session state and update accordingly.
    sessionManager.addListener(() {
      _updateState();
    });
  }

  // Update the state when the session changes.
  Future<void> _updateState() async {
    final sessionManager = ref.read(sessionManagerProvider);
    state = AuthState(
      userInfo: sessionManager.signedInUser,
      appUser: sessionManager.signedInUser != null ? await _fetchAppUser() : null,
    );
  }

  // Fetch the custom AppUser data from our backend.
  Future<AppUser?> _fetchAppUser() async {
    try {
      // This endpoint should return the AppUser with tool statuses
      return await ref.read(clientProvider).user.getMyPermissions();
    } catch (e) {
      // Handle errors, e.g., log them or return null
      print('Failed to fetch AppUser: $e');
      return null;
    }
  }

  // Perform login using the public API endpoint.
  Future<bool> login(String email, String password) async {
    try {
      // This custom public endpoint will return session info and tool status
      final result = await ref.read(clientProvider).publicApi.login(email, password);
      
      if (result.success && result.userInfo != null) {
        // If login is successful, register the user with the session manager.
        await ref.read(sessionManagerProvider).registerSignedInUser(
              result.userInfo!,
              result.keyId!,
              result.key!,
            );
        return true;
      }
      return false;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  // Perform logout.
  Future<void> logout() async {
    await ref.read(sessionManagerProvider).signOut();
  }
}

// The main provider for authentication state that the UI will interact with.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});