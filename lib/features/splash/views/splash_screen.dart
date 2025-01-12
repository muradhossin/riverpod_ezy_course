
import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/core/routes/routes.dart';
import 'package:boilerplate/features/login/controllers/login_provider.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends ConsumerState<SplashScreen> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    navigate();
  }

  void navigate() async {
     Timer(const Duration(seconds: 3), () {
        final notifier = ref.read(loginProvider.notifier);
        if(notifier.getToken() != null && notifier.getToken()!.isNotEmpty) {
          GoRouter.of(context).go(Routes.newsfeed);
          return;
        }
        GoRouter.of(context).go(Routes.login);
      });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    if (results.contains(ConnectivityResult.none)) {
      _showNoConnectionDialog();
    } else if (!_navigated) {
      _navigated = true; 
      Timer(const Duration(seconds: 3), () {
        final notifier = ref.read(loginProvider.notifier);
        if(notifier.getToken() != null && notifier.getToken()!.isNotEmpty) {
          GoRouter.of(context).go(Routes.newsfeed);
          return;
        }
        GoRouter.of(context).go(Routes.login);
      });
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet connection and try again.'),
        );
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CustomImage(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.5,
          imagePath: Images.nameTitleImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
