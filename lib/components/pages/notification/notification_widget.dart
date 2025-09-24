import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_model.dart';
export 'notification_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  static String routeName = 'Notification';
  static String routePath = '/notification';

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<ApiCallResponse> _notificationsFuture;
  late Future<ApiCallResponse> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationModel());
    _notificationsFuture = NotificationCall.call(token: FFAppState().token);
    _gamesFuture = GamesCall.call();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assets/images/bgimage.png').image,
          ),
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).primary,
              const Color(0xFF000B33)
            ],
            stops: const [0.0, 1.0],
            begin: const AlignmentDirectional(0.0, -1.0),
            end: const AlignmentDirectional(0, 1.0),
          ),
        ),
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 0.0, 0.0),
                      child: InkWell(
                        onTap: () async {
                          context.safePop();
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: const BoxDecoration(
                            color: Color(0x33FFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'NOTIFICATIONS',
                        style:
                            FlutterFlowTheme.of(context).displayLarge.override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .displayLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displayLarge
                                      .fontStyle,
                                ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filter chips row
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 0.0, 0.0),
                child: SizedBox(
                  height: 32.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _FilterChip(
                        label: 'All',
                        icon: const FaIcon(FontAwesomeIcons.alignJustify,
                            size: 18),
                        selected: _model.selectedButton == 'All',
                        onTap: () =>
                            setState(() => _model.selectedButton = 'All'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Game',
                        icon:
                            const Icon(Icons.sports_esports_rounded, size: 18),
                        selected: _model.selectedButton == 'Game',
                        onTap: () =>
                            setState(() => _model.selectedButton = 'Game'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Followers',
                        icon: const Icon(Icons.groups_outlined, size: 18),
                        selected: _model.selectedButton == 'Followers',
                        onTap: () =>
                            setState(() => _model.selectedButton = 'Followers'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Tournaments',
                        icon: const FaIcon(FontAwesomeIcons.trophy, size: 18),
                        selected: _model.selectedButton == 'Tournaments',
                        onTap: () => setState(
                            () => _model.selectedButton = 'Tournaments'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Challenges',
                        icon: const Icon(Icons.sensor_occupied, size: 18),
                        selected: _model.selectedButton == 'Challenges',
                        onTap: () => setState(
                            () => _model.selectedButton = 'Challenges'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: _notificationsFuture,
                  builder: (context, notifSnap) {
                    if (!notifSnap.hasData) {
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

                    // UPDATED: support both { notifications: [...] } and top-level array
                    final raw = notifSnap.data!.jsonBody;
                    final extracted = getJsonField(raw, r'$.notifications');
                    final List<dynamic> notifList = extracted is List
                        ? extracted
                        : (raw is List ? raw : []);

                    return FutureBuilder<ApiCallResponse>(
                      future: _gamesFuture,
                      builder: (context, gamesSnap) {
                        final gamesJson = gamesSnap.data?.jsonBody;
                        final gamesList = (gamesJson != null)
                            ? getJsonField(gamesJson, r'$.data')
                            : null;
                        final List<dynamic> games =
                            gamesList is List ? gamesList : const [];

                        if (notifList.isEmpty) {
                          return Center(
                            child: Text(
                              'No notifications',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 0, 10, 12),
                          itemCount: notifList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final item = notifList[index];

                            // UPDATED: title falls back to $.data.title if $.title is missing
                            final t1 = getJsonField(item, r'$.title');
                            final t2 = getJsonField(item, r'$.data.title');
                            final title = (t1 != null &&
                                    t1.toString() != 'null' &&
                                    t1.toString().trim().isNotEmpty)
                                ? t1.toString()
                                : (t2 != null && t2.toString() != 'null'
                                    ? t2.toString()
                                    : '');

                            final message =
                                getJsonField(item, r'$.message').toString();
                            final gameName =
                                getJsonField(item, r'$.data.game').toString();
                            final thumb = functions.gameImg(games, gameName);

                            return Container(
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0x16FFFFFF),
                                    Color(0x0DFFFFFF)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(10),
                                      image:
                                          title.isNotEmpty && thumb.isNotEmpty
                                              ? DecorationImage(
                                                  image: NetworkImage(thumb),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                    ),
                                    child: thumb.isEmpty
                                        ? Icon(
                                            Icons.notifications,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title.isNotEmpty
                                              ? title
                                              : 'Notification',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall
                                              .override(
                                                font: GoogleFonts.poppins(),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          message,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.poppins(),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final Widget icon;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? FlutterFlowTheme.of(context).secondaryBackground
        : const Color(0x0014181B);
    final fg = selected
        ? FlutterFlowTheme.of(context).primaryText
        : FlutterFlowTheme.of(context).secondaryBackground;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 12, 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            IconTheme(
              data: IconThemeData(color: fg, size: 18),
              child: icon,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: fg,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
