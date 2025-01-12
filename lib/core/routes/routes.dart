
import 'package:boilerplate/features/login/views/screens/login_screen.dart';
import 'package:boilerplate/features/newsfeed/views/screens/create_post_screen.dart';
import 'package:boilerplate/features/newsfeed/views/screens/newsfeed_screen.dart';
import 'package:boilerplate/features/splash/views/splash_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String newsfeed = '/newsfeed';
  static const String createPost = '/create-post';

  static final GoRouter routerConfig = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        name: splash,
        path: splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: newsfeed,
        path: newsfeed,
        builder: (context, state) => NewsfeedScreen(),
      ),
      GoRoute(
        name: createPost,
        path: createPost,
        builder: (context, state) => CreatePostScreen(),
      ),
    ]
  );
}
