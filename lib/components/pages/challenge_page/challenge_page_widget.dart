import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pop_ups/header/header_widget.dart';
import '/pop_ups/navbar/navbar_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'challenge_page_model.dart';
export 'challenge_page_model.dart';

class ChallengePageWidget extends StatefulWidget {
  const ChallengePageWidget({super.key});

  static String routeName = 'ChallengePage';
  static String routePath = '/challengePage';

  @override
  State<ChallengePageWidget> createState() => _ChallengePageWidgetState();
}

class _ChallengePageWidgetState extends State<ChallengePageWidget>
    with TickerProviderStateMixin {
  late ChallengePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  late Future<ApiCallResponse> profileResponse;
  late Future<ApiCallResponse> gamesResponse;
  // Full cached name lists (fetched once per page load)
  List<String> _userNames = [];
  List<String> _gameNames = [];
  // Live filtered lists updated via onChanged for snappier UX & to allow
  // future enhancements (debounce, server-side paging, etc.)
  List<String> _filteredUserNames = [];
  List<String> _filteredGameNames = [];
  late Future<ApiCallResponse> allUsersResponse;
  // Track challenge IDs currently being processed to prevent duplicate taps
  final Set<String> _processingChallengeIds = <String>{};

  // Safely resolve profile/remote images, falling back to a local asset when invalid.
  ImageProvider<Object> _safeNetworkOrAsset(String? url) {
    const fallback = AssetImage('assets/images/logo.png');
    if (url == null) return fallback;
    final u = url.trim();
    if (u.isEmpty) return fallback;
    final lower = u.toLowerCase();
    if (lower == 'null' || lower == 'undefined') return fallback;
    if (u.startsWith('http://') || u.startsWith('https://')) {
      return NetworkImage(u);
    }
    // If backend returns a relative path like "/uploads/...", prefix API host.
    if (u.startsWith('/')) {
      return NetworkImage('https://api.fulboost.fun$u');
    }
    return fallback;
  }

  late Future<ApiCallResponse> challengesResponse;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengePageModel());

    _model.textController1 ??= TextEditingController();

    _model.textController2 ??= TextEditingController();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
    profileResponse = ProfileCall.call(
      token: FFAppState().token,
      userId: FFAppState().userId,
    );
    // Initialize futures and populate local cached lists for autocomplete
    allUsersResponse = AllUsersCall.call(
      token: FFAppState().token,
    );
    challengesResponse = GetChallengesCall.call(
      token: FFAppState().token,
    );
    gamesResponse = GamesCall.call();
    allUsersResponse.then((resp) {
      try {
        final raw = resp.jsonBody;
        List<dynamic>? usersList;
        if (raw is List) {
          usersList = raw;
        } else if (raw is Map && raw['data'] is List) {
          usersList = raw['data'] as List<dynamic>;
        }
        final names = functions.fullNames(usersList) ?? [];
        if (mounted) {
          setState(() {
            _userNames = names.map((e) => e.toString()).toList();
            _filteredUserNames = List<String>.from(_userNames);
          });
        }
      } catch (e) {
        debugPrint('AllUsers parsing error: $e');
      }
    });
    gamesResponse.then((resp) {
      try {
        final raw = resp.jsonBody;
        List<dynamic>? gamesList;
        if (raw is List) {
          gamesList = raw;
        } else if (raw is Map && raw['data'] is List) {
          gamesList = raw['data'] as List<dynamic>;
        }
        final names = functions.gameNames(gamesList) ?? [];
        if (mounted) {
          setState(() {
            _gameNames = names.map((e) => e.toString()).toList();
            _filteredGameNames = List<String>.from(_gameNames);
          });
        }
      } catch (e) {
        debugPrint('Games parsing error: $e');
      }
    });
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  // Old fetch methods replaced by initState future initialization.

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF1565C0),
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/bgimage.png',
              ).image,
            ),
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).primary,
                const Color(0xFF000B33)
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1),
            ),
          ),
          alignment: const AlignmentDirectional(0, 0),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const HeaderWidget(),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 70),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: FutureBuilder<ApiCallResponse>(
                      future: allUsersResponse,
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final columnAllUsersResponse = snapshot.data!;

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width < 350.0
                                    ? 300.0
                                    : 350.0,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color(0xFF0BC1FF),
                                                      Color(0xFF0A2472)
                                                    ],
                                                    stops: [0, 1],
                                                    begin: AlignmentDirectional(
                                                        0, -1),
                                                    end: AlignmentDirectional(
                                                        0, 1),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderRadius: 50,
                                                  buttonSize: 36,
                                                  fillColor: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.home_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                        CommunityPageWidget
                                                            .routeName);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFF0BC1FF),
                                                        Color(0xFF0A2472)
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      end: AlignmentDirectional(
                                                          0, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: FlutterFlowIconButton(
                                                    borderRadius: 50,
                                                    buttonSize: 36,
                                                    fillColor:
                                                        Colors.transparent,
                                                    icon: Icon(
                                                      Icons.chat_bubble_outline,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      size: 20,
                                                    ),
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                          CommunitymembersWidget
                                                              .routeName);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0x33FFFFFF),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      child: Text(
                                        'Challenge',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: const Color(0xFFFBD34D),
                                              fontSize: 20,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFF3E2C2),
                                                    Color(0xFFE1B769)
                                                  ],
                                                  stops: [0, 1],
                                                  begin: AlignmentDirectional(
                                                      0, -1),
                                                  end: AlignmentDirectional(
                                                      0, 1),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 36,
                                                fillColor: Colors.transparent,
                                                icon: Icon(
                                                  Icons.sensor_occupied,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color(0xFF0BC1FF),
                                                      Color(0xFF0A2472)
                                                    ],
                                                    stops: [0, 1],
                                                    begin: AlignmentDirectional(
                                                        0, -1),
                                                    end: AlignmentDirectional(
                                                        0, 1),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderRadius: 50,
                                                  buttonSize: 36,
                                                  fillColor: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.leaderboard_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    context.pushNamed(
                                                        CommunityPageWidget
                                                            .routeName);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width < 350.0
                                    ? 280.0
                                    : 350.0,
                                height: 400,
                                decoration: BoxDecoration(
                                  color: const Color(0xBB08162C),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF00CFFF),
                                  ),
                                ),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: gamesResponse,
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final columnGamesResponse = snapshot.data!;
                                    return SingleChildScrollView(
                                      primary: false,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 10),
                                            child: Text(
                                              'Challenge a Friend',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        const Color(0xFFFBD34D),
                                                    fontSize: 24,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 250.0
                                                : 300.0,
                                            child: Autocomplete<String>(
                                              initialValue:
                                                  const TextEditingValue(),
                                              optionsBuilder:
                                                  (textEditingValue) {
                                                // When empty, show a capped list (first 20) for quick discovery
                                                if (textEditingValue
                                                    .text.isEmpty) {
                                                  return _filteredUserNames
                                                      .take(20);
                                                }
                                                final lower = textEditingValue
                                                    .text
                                                    .toLowerCase();
                                                return _userNames
                                                    .where((o) => o
                                                        .toLowerCase()
                                                        .contains(lower))
                                                    .take(20);
                                              },
                                              optionsViewBuilder: (context,
                                                  onSelected, options) {
                                                return AutocompleteOptionsList(
                                                  textFieldKey:
                                                      _model.textFieldKey1,
                                                  textController:
                                                      _model.textController1!,
                                                  options: options.toList(),
                                                  onSelected: onSelected,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  textHighlightStyle:
                                                      const TextStyle(),
                                                  elevation: 4,
                                                  optionBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  optionHighlightColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  maxHeight: 200,
                                                );
                                              },
                                              onSelected: (String selection) {
                                                safeSetState(() => _model
                                                        .textFieldSelectedOption1 =
                                                    selection);
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              fieldViewBuilder: (
                                                context,
                                                textEditingController,
                                                focusNode,
                                                onEditingComplete,
                                              ) {
                                                _model.textFieldFocusNode1 =
                                                    focusNode;

                                                _model.textController1 =
                                                    textEditingController;
                                                return TextFormField(
                                                  key: _model.textFieldKey1,
                                                  controller:
                                                      textEditingController,
                                                  focusNode: focusNode,
                                                  onEditingComplete:
                                                      onEditingComplete,
                                                  onChanged: (val) {
                                                    // Local filter; no extra rebuilds outside options list
                                                    final l = val.toLowerCase();

                                                    setState(() {
                                                      _filteredUserNames =
                                                          _userNames
                                                              .where((n) => n
                                                                  .toLowerCase()
                                                                  .contains(l))
                                                              .take(50)
                                                              .toList();
                                                    });
                                                  },
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintText:
                                                        'Enter Friend\'s Name',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 2,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0x33FFFFFF),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .textController1Validator
                                                      .asValidator(context),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 250.0
                                                : 300.0,
                                            child: Autocomplete<String>(
                                              initialValue:
                                                  const TextEditingValue(),
                                              optionsBuilder:
                                                  (textEditingValue) {
                                                if (textEditingValue
                                                    .text.isEmpty) {
                                                  return _filteredGameNames
                                                      .take(20);
                                                }
                                                final lower = textEditingValue
                                                    .text
                                                    .toLowerCase();
                                                return _gameNames
                                                    .where((o) => o
                                                        .toLowerCase()
                                                        .contains(lower))
                                                    .take(20);
                                              },
                                              optionsViewBuilder: (context,
                                                  onSelected, options) {
                                                return AutocompleteOptionsList(
                                                  textFieldKey:
                                                      _model.textFieldKey2,
                                                  textController:
                                                      _model.textController2!,
                                                  options: options.toList(),
                                                  onSelected: onSelected,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  textHighlightStyle:
                                                      const TextStyle(),
                                                  elevation: 4,
                                                  optionBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  optionHighlightColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  maxHeight: 200,
                                                );
                                              },
                                              onSelected: (String selection) {
                                                safeSetState(() => _model
                                                        .textFieldSelectedOption2 =
                                                    selection);
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              fieldViewBuilder: (
                                                context,
                                                textEditingController,
                                                focusNode,
                                                onEditingComplete,
                                              ) {
                                                _model.textFieldFocusNode2 =
                                                    focusNode;

                                                _model.textController2 =
                                                    textEditingController;
                                                return TextFormField(
                                                  key: _model.textFieldKey2,
                                                  controller:
                                                      textEditingController,
                                                  focusNode: focusNode,
                                                  onEditingComplete:
                                                      onEditingComplete,
                                                  onChanged: (val) {
                                                    final l = val.toLowerCase();
                                                    setState(() {
                                                      _filteredGameNames =
                                                          _gameNames
                                                              .where((n) => n
                                                                  .toLowerCase()
                                                                  .contains(l))
                                                              .take(50)
                                                              .toList();
                                                    });
                                                  },
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                    hintText: 'Enter game name',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                          lineHeight: 2,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0x33FFFFFF),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  enableInteractiveSelection:
                                                      true,
                                                  validator: _model
                                                      .textController2Validator
                                                      .asValidator(context),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 250.0
                                                : 300.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController3,
                                              focusNode:
                                                  _model.textFieldFocusNode3,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText:
                                                    'Entry Fee (₹0 or more)',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        0, 249, 243, 243),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    const Color(0x33FFFFFF),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLines: 1,
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController3Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 10),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                // Parse entry fee from text field (default to 0 if empty or invalid)
                                                final entryFee = int.tryParse(
                                                        _model.textController3
                                                            .text
                                                            .trim()) ??
                                                    0;

                                                // Validate entry fee is non-negative
                                                if (entryFee < 0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Entry fee cannot be negative'),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                  return;
                                                }

                                                _model.challenges =
                                                    await ChallengesCall.call(
                                                  challengedUserId:
                                                      functions.challangeTo(
                                                          getJsonField(
                                                            columnAllUsersResponse
                                                                .jsonBody,
                                                            r'''$.data''',
                                                            true,
                                                          )!,
                                                          _model.textController1
                                                              .text),
                                                  gameId: functions.findgameId(
                                                      getJsonField(
                                                        columnGamesResponse
                                                            .jsonBody,
                                                        r'''$.data''',
                                                        true,
                                                      )!,
                                                      _model.textController2
                                                          .text),
                                                  entryFee: entryFee,
                                                  token: FFAppState().token,
                                                );

                                                if ((_model.challenges
                                                        ?.succeeded ??
                                                    true)) {
                                                  // Extract challenge ID from response
                                                  final challengeId =
                                                      getJsonField(
                                                            _model.challenges
                                                                ?.jsonBody,
                                                            r'''$.challenge._id''',
                                                          )?.toString() ??
                                                          '';

                                                  final gameUrl =
                                                      functions.gameURL(
                                                          getJsonField(
                                                            columnGamesResponse
                                                                .jsonBody,
                                                            r'''$.data''',
                                                            true,
                                                          )!,
                                                          _model.textController2
                                                              .text);

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Challenge sent! Starting game...',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 2000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );

                                                  // Navigate to GameOn2 with challenge ID
                                                  if (challengeId.isNotEmpty &&
                                                      gameUrl.isNotEmpty) {
                                                    context.pushNamed(
                                                      'gameOn2',
                                                      queryParameters: {
                                                        'gameUrl':
                                                            serializeParam(
                                                          gameUrl,
                                                          ParamType.String,
                                                        ),
                                                        'gamename':
                                                            serializeParam(
                                                          _model.textController2
                                                              .text,
                                                          ParamType.String,
                                                        ),
                                                        'challangeId':
                                                            serializeParam(
                                                          challengeId,
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "error occurs",
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }

                                                safeSetState(() {});
                                              },
                                              text: 'Send challenge',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                                .width <
                                                            350.0
                                                        ? 250.0
                                                        : 300.0,
                                                height: 40,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 0, 16, 0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'buttonOnPageLoadAnimation']!),
                                          ),
                                        ]
                                            .divide(const SizedBox(height: 20))
                                            .addToStart(
                                                const SizedBox(height: 10)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  if (_model.availChallenges) {
                                    return Container(
                                      width: MediaQuery.sizeOf(context).width <
                                              350.0
                                          ? 280.0
                                          : 350.0,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFF00CFFF),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, -1),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _model.availChallenges =
                                                          false;
                                                    });
                                                  },
                                                  child: Text(
                                                    '<- Sended Invites',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: const Color(
                                                              0xFFFBD34D),
                                                          fontSize: 24,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ]
                                                  .divide(const SizedBox(
                                                      height: 20))
                                                  .addToStart(const SizedBox(
                                                      height: 10)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 50, 0, 0),
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: challengesResponse,
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final listViewGamesResponse =
                                                    snapshot.data!;
                                                return Builder(
                                                  builder: (context) {
                                                    final allChallenges =
                                                        getJsonField(
                                                      listViewGamesResponse
                                                          .jsonBody,
                                                      r'''$.challenges''',
                                                    ).toList();
                                                    final myUserId =
                                                        FFAppState().userId;
                                                    // Filter incoming invites: only where current user is the challenged recipient
                                                    // and ensure current user is not the challenger.
                                                    final challenge =
                                                        allChallenges
                                                            .where((c) {
                                                      String challengedId =
                                                          getJsonField(c,
                                                                      r'''$.challengedUser._id''')
                                                                  ?.toString() ??
                                                              '';
                                                      if (challengedId
                                                              .isEmpty ||
                                                          challengedId ==
                                                              'null') {
                                                        challengedId = getJsonField(
                                                                    c,
                                                                    r'''$.challenged._id''')
                                                                ?.toString() ??
                                                            '';
                                                      }

                                                      if (challengedId
                                                              .isEmpty ||
                                                          challengedId ==
                                                              'null') {
                                                        challengedId = getJsonField(
                                                                    c,
                                                                    r'''$.challenged.id''')
                                                                ?.toString() ??
                                                            '';
                                                      }

                                                      String challengerId =
                                                          getJsonField(c,
                                                                      r'''$.challenger._id''')
                                                                  ?.toString() ??
                                                              '';
                                                      if (challengerId
                                                              .isEmpty ||
                                                          challengerId ==
                                                              'null') {
                                                        challengerId = getJsonField(
                                                                    c,
                                                                    r'''$.challenger.id''')
                                                                ?.toString() ??
                                                            '';
                                                      }

                                                      final isChallengedMe =
                                                          challengedId ==
                                                              myUserId;
                                                      final isChallengerMe =
                                                          challengerId ==
                                                              myUserId;
                                                      return isChallengedMe &&
                                                          !isChallengerMe;
                                                    }).toList();
                                                    debugPrint(
                                                        '[INCOMING] total=${allChallenges.length}, filtered=${challenge.length}');
                                                    return ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          challenge.length,
                                                      separatorBuilder:
                                                          (_, __) =>
                                                              const SizedBox(
                                                                  height: 10),
                                                      itemBuilder: (context,
                                                          challengeIndex) {
                                                        final status =
                                                            getJsonField(
                                                          challenge[
                                                              challengeIndex],
                                                          r'''$.status''',
                                                        )
                                                                .toString()
                                                                .toLowerCase();

                                                        final challengerName =
                                                            getJsonField(
                                                          challenge[
                                                              challengeIndex],
                                                          r'''$.challenger.fullName''',
                                                        ).toString();
                                                        final gameName =
                                                            getJsonField(
                                                          challenge[
                                                              challengeIndex],
                                                          r'''$.game.displayName''',
                                                        ).toString();
                                                        return Container(
                                                          height: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  10, 0, 10, 0),
                                                          child: Row(
                                                            children: [
                                                              // Avatar
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        10,
                                                                        0),
                                                                child:
                                                                    Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xFF57636C),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image:
                                                                          _safeNetworkOrAsset(
                                                                        getJsonField(
                                                                          challenge[
                                                                              challengeIndex],
                                                                          r'''$.challenger.profilePicture''',
                                                                        ).toString(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Names & game
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      challengerName,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            2),
                                                                    Row(
                                                                      children: [
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidCircle,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          size:
                                                                              10,
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            gameName,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.poppins(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            2),
                                                                    // Score display
                                                                    Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final challengerScore =
                                                                            getJsonField(
                                                                          challenge[
                                                                              challengeIndex],
                                                                          r'''$.result.score.challenger''',
                                                                        );
                                                                        final challengedScore =
                                                                            getJsonField(
                                                                          challenge[
                                                                              challengeIndex],
                                                                          r'''$.result.score.challenged''',
                                                                        );

                                                                        String
                                                                            scoreText;
                                                                        if (status ==
                                                                            'pending') {
                                                                          // Pending: Show "You: Waiting" and opponent score if exists
                                                                          final opponentScoreStr = challengerScore != null
                                                                              ? challengerScore.toString()
                                                                              : 'Pending';
                                                                          scoreText =
                                                                              'You: Waiting | Opponent: $opponentScoreStr';
                                                                        } else if (status ==
                                                                                'completed' ||
                                                                            status ==
                                                                                'accepted') {
                                                                          // Completed/Accepted: Show both scores
                                                                          final yourScore =
                                                                              challengedScore?.toString() ?? '-';
                                                                          final oppScore =
                                                                              challengerScore?.toString() ?? '-';
                                                                          scoreText =
                                                                              'You: $yourScore | Opponent: $oppScore';
                                                                        } else {
                                                                          scoreText =
                                                                              '';
                                                                        }

                                                                        if (scoreText
                                                                            .isEmpty)
                                                                          return const SizedBox
                                                                              .shrink();

                                                                        return Text(
                                                                          scoreText,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.poppins(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: const Color(0xFFB0B0B0),
                                                                                fontSize: 11,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Actions / status
                                                              if (status ==
                                                                  'pending')
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        final id =
                                                                            getJsonField(
                                                                          challenge[
                                                                              challengeIndex],
                                                                          r'''$._id''',
                                                                        ).toString();

                                                                        // Prevent duplicate processing
                                                                        if (_processingChallengeIds
                                                                            .contains(id)) {
                                                                          return;
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          _processingChallengeIds
                                                                              .add(id);
                                                                        });

                                                                        try {
                                                                          final apiResult =
                                                                              await AcceptChallengeCall.call(
                                                                            token:
                                                                                FFAppState().token,
                                                                            challengeId:
                                                                                id,
                                                                          );

                                                                          // Check JSON success field (primary check)
                                                                          final success =
                                                                              getJsonField(
                                                                            apiResult.jsonBody,
                                                                            r'''$.success''',
                                                                          );

                                                                          // Check if API response has success: true in JSON
                                                                          if (success ==
                                                                              true) {
                                                                            // Check if widget is still mounted before UI operations
                                                                            if (!mounted)
                                                                              return;

                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text('Challenge accepted! Starting game...', style: FlutterFlowTheme.of(context).bodyMedium),
                                                                                duration: const Duration(milliseconds: 2000),
                                                                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                behavior: SnackBarBehavior.floating,
                                                                              ),
                                                                            );

                                                                            // Get game name from challenge
                                                                            final acceptedChallenge =
                                                                                getJsonField(
                                                                              apiResult.jsonBody,
                                                                              r'''$.challenge''',
                                                                            );

                                                                            final gameName = getJsonField(
                                                                                  acceptedChallenge,
                                                                                  r'''$.game.displayName''',
                                                                                )?.toString() ??
                                                                                '';

                                                                            print('Game Name: $gameName');

                                                                            // Fetch games list to get proper game URL
                                                                            final gamesApiResult =
                                                                                await GamesCall.call();

                                                                            // Use the same gameURL function as send challenge
                                                                            final gameUrl =
                                                                                functions.gameURL(
                                                                              getJsonField(
                                                                                gamesApiResult.jsonBody,
                                                                                r'''$.data''',
                                                                                true,
                                                                              )!,
                                                                              gameName,
                                                                            );

                                                                            // Check mounted again before navigation
                                                                            if (!mounted)
                                                                              return;

                                                                            // Navigate to GameOn2 with challenge ID
                                                                            if (gameUrl.isNotEmpty) {
                                                                              context.pushNamed(
                                                                                'gameOn2',
                                                                                queryParameters: {
                                                                                  'gameUrl': serializeParam(
                                                                                    gameUrl,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                  'gamename': serializeParam(
                                                                                    gameName,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                  'challangeId': serializeParam(
                                                                                    id,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );
                                                                            } else {
                                                                              print('⚠️ Game URL is empty, cannot navigate');
                                                                              if (mounted) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(
                                                                                    content: Text('Could not load game. Please try again.', style: FlutterFlowTheme.of(context).bodyMedium),
                                                                                    duration: const Duration(milliseconds: 2000),
                                                                                    backgroundColor: Colors.red,
                                                                                    behavior: SnackBarBehavior.floating,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            }

                                                                            if (mounted) {
                                                                              setState(() {
                                                                                challengesResponse = GetChallengesCall.call(token: FFAppState().token);
                                                                              });
                                                                            }
                                                                          } else {
                                                                            print('❌ Challenge accept failed!');
                                                                            print('API Status Code: ${apiResult.statusCode}');
                                                                            print('API Succeeded: ${apiResult.succeeded}');
                                                                            print('JSON Success: $success');
                                                                            print('Response Body: ${apiResult.jsonBody}');

                                                                            if (!mounted)
                                                                              return;

                                                                            final message = getJsonField(
                                                                                  apiResult.jsonBody,
                                                                                  r'''$.message''',
                                                                                )?.toString() ??
                                                                                'Failed to accept challenge. Please try again.';

                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text(message, style: FlutterFlowTheme.of(context).bodyMedium),
                                                                                duration: const Duration(milliseconds: 2000),
                                                                                backgroundColor: Colors.red,
                                                                                behavior: SnackBarBehavior.floating,
                                                                              ),
                                                                            );
                                                                          }
                                                                        } catch (e) {
                                                                          print(
                                                                              '❌ Exception during accept: $e');
                                                                          // Don't try to show UI on deactivated widget
                                                                          // The error is already logged
                                                                        } finally {
                                                                          if (mounted) {
                                                                            setState(() {
                                                                              _processingChallengeIds.remove(id);
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      text:
                                                                          'Accept',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        height:
                                                                            30,
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                        color: const Color(
                                                                            0xFF2ECC71),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(),
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                        elevation:
                                                                            0,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            6),
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        final id =
                                                                            getJsonField(
                                                                          challenge[
                                                                              challengeIndex],
                                                                          r'''$._id''',
                                                                        ).toString();
                                                                        if (_processingChallengeIds
                                                                            .contains(id)) {
                                                                          return;
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          _processingChallengeIds
                                                                              .add(id);
                                                                        });
                                                                        try {
                                                                          final response =
                                                                              await RejectChallengeCall.call(
                                                                            challengeId:
                                                                                id,
                                                                            token:
                                                                                FFAppState().token,
                                                                          );
                                                                          if (response.succeeded ==
                                                                              true) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text('Challenge rejected!', style: FlutterFlowTheme.of(context).bodyMedium),
                                                                                duration: const Duration(milliseconds: 1500),
                                                                                backgroundColor: const Color(0x00000000),
                                                                                behavior: SnackBarBehavior.floating,
                                                                              ),
                                                                            );
                                                                            setState(() {
                                                                              challengesResponse = GetChallengesCall.call(token: FFAppState().token);
                                                                            });
                                                                          }
                                                                        } finally {
                                                                          if (mounted) {
                                                                            setState(() {
                                                                              _processingChallengeIds.remove(id);
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      text:
                                                                          'Reject',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        height:
                                                                            30,
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                        color: const Color(
                                                                            0xFFE74C3C),
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(),
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                        elevation:
                                                                            0,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              else
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    // Get winner information for completed challenges
                                                                    final myUserId =
                                                                        FFAppState()
                                                                            .userId;
                                                                    final winnerId =
                                                                        getJsonField(
                                                                              challenge[challengeIndex],
                                                                              r'''$.result.winner''',
                                                                            )?.toString() ??
                                                                            '';
                                                                    print(
                                                                        'Winner ID: $winnerId, My User ID: $myUserId, Status: $status');
                                                                    String
                                                                        statusLabel;
                                                                    Color
                                                                        statusColor;

                                                                    if (status ==
                                                                        'completed') {
                                                                      // Completed status - show win/loss/tie
                                                                      if (winnerId
                                                                          .isNotEmpty) {
                                                                        if (winnerId ==
                                                                            myUserId) {
                                                                          statusColor =
                                                                              const Color(0xFF2ECC71);
                                                                          statusLabel =
                                                                              '🏆 Won';
                                                                        } else {
                                                                          statusColor =
                                                                              const Color(0xFFE74C3C);
                                                                          statusLabel =
                                                                              '❌ Lost';
                                                                        }
                                                                      } else {
                                                                        // Tie
                                                                        statusColor =
                                                                            const Color(0xFFFFA500);
                                                                        statusLabel =
                                                                            '🤝 Tie';
                                                                      }
                                                                    } else if (status ==
                                                                        'accepted') {
                                                                      // Accepted status - just show accepted
                                                                      statusColor =
                                                                          const Color(
                                                                              0xFF2ECC71);
                                                                      statusLabel =
                                                                          'Accepted';
                                                                    } else {
                                                                      // Rejected status
                                                                      statusColor =
                                                                          const Color(
                                                                              0xFFE74C3C);
                                                                      statusLabel =
                                                                          'Rejected';
                                                                    }

                                                                    return Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          8,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Text(
                                                                        statusLabel,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle),
                                                                              color: statusColor,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ); // end incoming invites inner ListView builder
                                              }, // end FutureBuilder builder
                                            ),
                                          ),
                                        ],
                                      ), // end Incoming Invites stack
                                    ); // close Incoming Invites Container
                                    // close if branch container
                                  } else {
                                    // Sent Challenges (outgoing)
                                    return Container(
                                      width: MediaQuery.sizeOf(context).width <
                                              350.0
                                          ? 280.0
                                          : 350.0,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: const Color(0xBB08162C),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFF00CFFF),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, -1),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _model.availChallenges =
                                                          true;
                                                    });
                                                  },
                                                  child: Text(
                                                    'Incoming Invites ->',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .roboto(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: const Color(
                                                              0xFFFBD34D),
                                                          fontSize: 24,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ]
                                                  .divide(const SizedBox(
                                                      height: 20))
                                                  .addToStart(const SizedBox(
                                                      height: 10)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 50, 0, 0),
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: challengesResponse,
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final resp = snapshot.data!;
                                                final allChallenges =
                                                    (getJsonField(
                                                          resp.jsonBody,
                                                          r'''$.challenges''',
                                                        ) as List?)
                                                            ?.toList() ??
                                                        [];

                                                // Filter to challenges sent by current user (challenger.id == current user)
                                                final myUserId =
                                                    FFAppState().userId;
                                                final sentChallenges =
                                                    allChallenges.where((c) {
                                                  String challengerId =
                                                      getJsonField(c,
                                                                  r'''$.challenger._id''')
                                                              ?.toString() ??
                                                          '';
                                                  if (challengerId.isEmpty ||
                                                      challengerId == 'null') {
                                                    challengerId = getJsonField(
                                                                c,
                                                                r'''$.challenger.id''')
                                                            ?.toString() ??
                                                        '';
                                                  }
                                                  return challengerId ==
                                                      myUserId;
                                                }).toList();

                                                if (sentChallenges.isEmpty) {
                                                  return Center(
                                                    child: Text(
                                                      'No sent challenges yet.',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  );
                                                }

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      sentChallenges.length,
                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(
                                                          height: 10),
                                                  itemBuilder: (context, idx) {
                                                    final c =
                                                        sentChallenges[idx];
                                                    final status = (getJsonField(
                                                                    c,
                                                                    r'''$.status''')
                                                                ?.toString() ??
                                                            '')
                                                        .toLowerCase();

                                                    // Try to pick challenged user's details from common keys
                                                    String targetName = '';
                                                    for (final p in const [
                                                      r'''$.challengedUser.fullName''',
                                                      r'''$.challengee.fullName''',
                                                      r'''$.recipient.fullName''',
                                                      r'''$.challenged.fullName''',
                                                    ]) {
                                                      final v =
                                                          getJsonField(c, p);
                                                      if (v != null) {
                                                        final s = v.toString();
                                                        if (s.isNotEmpty &&
                                                            s != 'null') {
                                                          targetName = s;
                                                          break;
                                                        }
                                                      }
                                                    }
                                                    if (targetName.isEmpty) {
                                                      targetName = 'Opponent';
                                                    }

                                                    String avatarUrl = '';
                                                    for (final p in const [
                                                      r'''$.challengedUser.profilePicture''',
                                                      r'''$.challengee.profilePicture''',
                                                      r'''$.recipient.profilePicture''',
                                                      r'''$.challenged.profilePicture''',
                                                    ]) {
                                                      final v =
                                                          getJsonField(c, p);
                                                      if (v != null) {
                                                        final s = v.toString();
                                                        if (s.isNotEmpty &&
                                                            s != 'null') {
                                                          avatarUrl = s;
                                                          break;
                                                        }
                                                      }
                                                    }

                                                    final gameName = getJsonField(
                                                                c,
                                                                r'''$.game.displayName''')
                                                            ?.toString() ??
                                                        '';

                                                    // Get winner information for completed challenges
                                                    final myUserId =
                                                        FFAppState().userId;
                                                    final winnerId = getJsonField(
                                                                c,
                                                                r'''$.result.winner''')
                                                            ?.toString() ??
                                                        '';
                                                    print(
                                                        'Winner ID: $winnerId, My User ID: $myUserId, Status: $status');

                                                    Color statusColor;
                                                    String statusLabel;
                                                    if (status == 'completed') {
                                                      // Completed status - show win/loss/tie
                                                      if (winnerId.isNotEmpty) {
                                                        if (winnerId ==
                                                            myUserId) {
                                                          statusColor =
                                                              const Color(
                                                                  0xFF2ECC71);
                                                          statusLabel =
                                                              '🏆 Won';
                                                        } else {
                                                          statusColor =
                                                              const Color(
                                                                  0xFFE74C3C);
                                                          statusLabel =
                                                              '❌ Lost';
                                                        }
                                                      } else {
                                                        // Tie
                                                        statusColor =
                                                            const Color(
                                                                0xFFFFA500);
                                                        statusLabel = '🤝 Tie';
                                                      }
                                                    } else if (status ==
                                                        'accepted') {
                                                      statusColor = const Color(
                                                          0xFF2ECC71);
                                                      statusLabel = 'Accepted';
                                                    } else if (status ==
                                                        'rejected') {
                                                      statusColor = const Color(
                                                          0xFFE74C3C);
                                                      statusLabel = 'Rejected';
                                                    } else {
                                                      // Pending - button will show instead
                                                      statusColor = const Color(
                                                          0xFFFFA500);
                                                      statusLabel = 'Pending';
                                                    }

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              5, 0, 5, 0),
                                                      child: Container(
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  10, 0, 10, 0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            35,
                                                                        height:
                                                                            35,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xFF57636C),
                                                                          image:
                                                                              DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image:
                                                                                _safeNetworkOrAsset(avatarUrl),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              targetName,
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.poppins(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: MediaQuery.sizeOf(context).width < 350.0 ? 14.0 : 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                const FaIcon(
                                                                                  FontAwesomeIcons.solidCircle,
                                                                                  size: 12,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                  child: Text(
                                                                                    gameName,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.poppins(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: MediaQuery.sizeOf(context).width < 350.0 ? 10.0 : 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            // Score display for sent challenges
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final challengerScore = getJsonField(
                                                                                  c,
                                                                                  r'''$.result.score.challenger''',
                                                                                );
                                                                                final challengedScore = getJsonField(
                                                                                  c,
                                                                                  r'''$.result.score.challenged''',
                                                                                );

                                                                                String scoreText;
                                                                                if (status == 'pending') {
                                                                                  // Pending: Show your score and "Opponent: Pending"
                                                                                  final yourScoreStr = challengerScore != null ? challengerScore.toString() : 'Waiting';
                                                                                  scoreText = 'You: $yourScoreStr | Opponent: Pending';
                                                                                } else if (status == 'completed' || status == 'accepted') {
                                                                                  // Completed/Accepted: Show both scores
                                                                                  final yourScore = challengerScore?.toString() ?? '-';
                                                                                  final oppScore = challengedScore?.toString() ?? '-';
                                                                                  scoreText = 'You: $yourScore | Opponent: $oppScore';
                                                                                } else {
                                                                                  scoreText = '';
                                                                                }

                                                                                if (scoreText.isEmpty) return const SizedBox.shrink();

                                                                                return Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                                                                  child: Text(
                                                                                    scoreText,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.poppins(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: const Color(0xFFB0B0B0),
                                                                                          fontSize: MediaQuery.sizeOf(context).width < 350.0 ? 9.0 : 11.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Show Cancel button for pending, status text for others
                                                              if (status ==
                                                                  'pending')
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    final id =
                                                                        getJsonField(
                                                                      c,
                                                                      r'''$._id''',
                                                                    ).toString();
                                                                    if (_processingChallengeIds
                                                                        .contains(
                                                                            id)) {
                                                                      return;
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      _processingChallengeIds
                                                                          .add(
                                                                              id);
                                                                    });
                                                                    try {
                                                                      final response =
                                                                          await RejectChallengeCall
                                                                              .call(
                                                                        challengeId:
                                                                            id,
                                                                        token: FFAppState()
                                                                            .token,
                                                                      );
                                                                      if (mounted) {
                                                                        if (response.succeeded ==
                                                                            true) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text('Challenge cancelled!', style: FlutterFlowTheme.of(context).bodyMedium),
                                                                              duration: const Duration(milliseconds: 1500),
                                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                              behavior: SnackBarBehavior.floating,
                                                                            ),
                                                                          );
                                                                          setState(
                                                                              () {
                                                                            challengesResponse =
                                                                                GetChallengesCall.call(token: FFAppState().token);
                                                                          });
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              content: Text('Failed to cancel challenge', style: FlutterFlowTheme.of(context).bodyMedium),
                                                                              duration: const Duration(milliseconds: 1500),
                                                                              backgroundColor: const Color(0xFFE74C3C),
                                                                              behavior: SnackBarBehavior.floating,
                                                                            ),
                                                                          );
                                                                        }
                                                                      }
                                                                    } finally {
                                                                      if (mounted) {
                                                                        setState(
                                                                            () {
                                                                          _processingChallengeIds
                                                                              .remove(id);
                                                                        });
                                                                      }
                                                                    }
                                                                  },
                                                                  text:
                                                                      'Cancel',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 30,
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                    color: const Color(
                                                                        0xFFE74C3C),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.poppins(),
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                )
                                                              else
                                                                Text(
                                                                  statusLabel,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color:
                                                                            statusColor,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ); // END sent challenges listview
                                              },
                                            ),
                                          ),
                                        ],
                                      ), // end Sent Challenges stack
                                    ); // close Sent Challenges Container
                                  }
                                },
                              ), // end outer Builder for challenges toggle
                            ]
                                .divide(const SizedBox(height: 10))
                                .addToStart(const SizedBox(height: 20)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.navbarModel,
                updateCallback: () => safeSetState(() {}),
                child: const NavbarWidget(
                  pageNav: 'CommunityPage',
                ),
              ),
            ],
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
      ),
    );
  }
}
