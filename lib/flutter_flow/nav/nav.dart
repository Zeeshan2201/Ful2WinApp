import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => HomePageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => HomePageWidget(),
        ),
        FFRoute(
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          builder: (context, params) => HomePageWidget(),
        ),
        FFRoute(
          name: LoginpageWidget.routeName,
          path: LoginpageWidget.routePath,
          builder: (context, params) => LoginpageWidget(),
        ),
        FFRoute(
          name: ProfilepageWidget.routeName,
          path: ProfilepageWidget.routePath,
          builder: (context, params) => ProfilepageWidget(),
        ),
        FFRoute(
          name: WalletpageWidget.routeName,
          path: WalletpageWidget.routePath,
          builder: (context, params) => WalletpageWidget(),
        ),
        FFRoute(
          name: SignuppageWidget.routeName,
          path: SignuppageWidget.routePath,
          builder: (context, params) => SignuppageWidget(),
        ),
        FFRoute(
          name: GamesPageWidget.routeName,
          path: GamesPageWidget.routePath,
          builder: (context, params) => GamesPageWidget(),
        ),
        FFRoute(
          name: TournamentPageWidget.routeName,
          path: TournamentPageWidget.routePath,
          builder: (context, params) => TournamentPageWidget(),
        ),
        FFRoute(
          name: HistoryWidget.routeName,
          path: HistoryWidget.routePath,
          builder: (context, params) => HistoryWidget(),
        ),
        FFRoute(
          name: KycstatusWidget.routeName,
          path: KycstatusWidget.routePath,
          builder: (context, params) => KycstatusWidget(),
        ),
        FFRoute(
          name: ComingSoonWidget.routeName,
          path: ComingSoonWidget.routePath,
          builder: (context, params) => ComingSoonWidget(),
        ),
        FFRoute(
          name: NotificationWidget.routeName,
          path: NotificationWidget.routePath,
          builder: (context, params) => NotificationWidget(),
        ),
        FFRoute(
          name: SupportpageWidget.routeName,
          path: SupportpageWidget.routePath,
          builder: (context, params) => SupportpageWidget(),
        ),
        FFRoute(
          name: TournamentLobbyWidget.routeName,
          path: TournamentLobbyWidget.routePath,
          builder: (context, params) => TournamentLobbyWidget(
            gameId: params.getParam(
              'gameId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ReferralspageWidget.routeName,
          path: ReferralspageWidget.routePath,
          builder: (context, params) => ReferralspageWidget(),
        ),
        FFRoute(
          name: AddMoneyPageWidget.routeName,
          path: AddMoneyPageWidget.routePath,
          builder: (context, params) => AddMoneyPageWidget(),
        ),
        FFRoute(
          name: AccountpageWidget.routeName,
          path: AccountpageWidget.routePath,
          builder: (context, params) => AccountpageWidget(),
        ),
        FFRoute(
          name: LeaderBoardPageWidget.routeName,
          path: LeaderBoardPageWidget.routePath,
          builder: (context, params) => LeaderBoardPageWidget(),
        ),
        FFRoute(
          name: AdsPageWidget.routeName,
          path: AdsPageWidget.routePath,
          builder: (context, params) => AdsPageWidget(),
        ),
        FFRoute(
          name: EditAccountpageWidget.routeName,
          path: EditAccountpageWidget.routePath,
          builder: (context, params) => EditAccountpageWidget(),
        ),
        FFRoute(
          name: TransactionHistoryWidget.routeName,
          path: TransactionHistoryWidget.routePath,
          builder: (context, params) => TransactionHistoryWidget(),
        ),
        FFRoute(
          name: CommunityleaderboardWidget.routeName,
          path: CommunityleaderboardWidget.routePath,
          builder: (context, params) => CommunityleaderboardWidget(),
        ),
        FFRoute(
          name: ChallengePageWidget.routeName,
          path: ChallengePageWidget.routePath,
          builder: (context, params) => ChallengePageWidget(),
        ),
        FFRoute(
          name: KycstatusSubmitWidget.routeName,
          path: KycstatusSubmitWidget.routePath,
          builder: (context, params) => KycstatusSubmitWidget(),
        ),
        FFRoute(
          name: MessageWidget.routeName,
          path: MessageWidget.routePath,
          builder: (context, params) => MessageWidget(),
        ),
        FFRoute(
          name: WithdrawPageWidget.routeName,
          path: WithdrawPageWidget.routePath,
          builder: (context, params) => WithdrawPageWidget(),
        ),
        FFRoute(
          name: HomePageCopyWidget.routeName,
          path: HomePageCopyWidget.routePath,
          builder: (context, params) => HomePageCopyWidget(),
        ),
        FFRoute(
          name: GameOnWidget.routeName,
          path: GameOnWidget.routePath,
          builder: (context, params) => GameOnWidget(
            gameUrl: params.getParam(
              'gameUrl',
              ParamType.String,
            ),
            gamename: params.getParam(
                  'gamename',
                  ParamType.String,
                ) ??
                'DefaultGame',
            tournamentId: params.getParam(
                  'tournamentId',
                  ParamType.String,
                ) ??
                'DefaultGame', // fallback if param not passed
          ),
        ),
        FFRoute(
          name: HomePageCopyCopyWidget.routeName,
          path: HomePageCopyCopyWidget.routePath,
          builder: (context, params) => HomePageCopyCopyWidget(),
        ),
        FFRoute(
          name: CommunitymembersWidget.routeName,
          path: CommunitymembersWidget.routePath,
          builder: (context, params) => CommunitymembersWidget(),
        ),
        FFRoute(
          name: HomePageCopy2Widget.routeName,
          path: HomePageCopy2Widget.routePath,
          builder: (context, params) => HomePageCopy2Widget(),
        ),
        FFRoute(
          name: CommunityPageWidget.routeName,
          path: CommunityPageWidget.routePath,
          builder: (context, params) => CommunityPageWidget(
            isExpanded: params.getParam(
              'isExpanded',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: LeaderBoardPageNEWCopyWidget.routeName,
          path: LeaderBoardPageNEWCopyWidget.routePath,
          builder: (context, params) => LeaderBoardPageNEWCopyWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
