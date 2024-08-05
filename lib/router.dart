// The route configuration.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/start_page.dart';

import 'features/auth/view/login_page.dart';
import 'features/auth/view/signup_page.dart';
import 'features/tasks/view/home_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {

        if(FirebaseAuth.instance.currentUser!=null){
          return HomePage(user: FirebaseAuth.instance.currentUser!);
        }
        return const StartPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'startPage',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: StartPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.75, 0), // Slide from right
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );

              },
            );
          },
        ),
        GoRoute(
          path: 'home',
          pageBuilder: (context, state) {
            User user = state.extra as User;
            return CustomTransitionPage(
              key: state.pageKey,
              child: HomePage(user: user,),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.75, 0), // Slide from right
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );

              },
            );
          },
        ),
        GoRoute(
          path: 'login',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: LoginPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.75, 0), // Slide from right
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );

              },
            );
          },
        ),
        GoRoute(
          path: 'signup',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SignUpPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.75, 0), // Slide from right
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );

              },
            );
          },
        ),
      ],
    ),
  ],
);

