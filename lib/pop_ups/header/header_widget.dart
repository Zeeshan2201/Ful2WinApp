import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart'; // ✅ make sure SpinWheelWidget is exported in index.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'header_model.dart';
export 'header_model.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late HeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  late Future<ApiCallResponse> profileResponse;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderModel());
    profileResponse = ProfileCall.call(
      token: FFAppState().token,
      userId: FFAppState().userId,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: const AlignmentDirectional(0.0, -1.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
        child: FutureBuilder<ApiCallResponse>(
          future: profileResponse,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }
            final containerProfileResponse = snapshot.data!;

            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                FFAppState().profilePicture = getJsonField(
                  containerProfileResponse.jsonBody,
                  r'''$.profilePicture''',
                ).toString();
                safeSetState(() {});
              },
              child: Container(
                width: double.infinity,
                height: 60.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF0A2472)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 0.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(HomePageWidget.routeName);
                        },
                        child: Container(
                          width: 60.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset(
                                'assets/images/logo.png',
                              ).image,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Wallet + Notifications + Spin Wheel
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 8.0, 0.0),
                      child: SizedBox(
                        width: 134.0,
                        height: 32.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Wallet
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(WalletpageWidget.routeName);
                              },
                              child: Container(
                                width: 61.0,
                                height: 23.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    Text(
                                      getJsonField(
                                        containerProfileResponse.jsonBody,
                                        r'''$.coins''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Notifications
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 35.0,
                                icon: const Icon(
                                  Icons.notifications_sharp,
                                  color: Color(0xFFAECBF9),
                                  size: 22.0,
                                ),
                                onPressed: () async {
                                  context
                                      .pushNamed(NotificationWidget.routeName);
                                },
                              ),
                            ),

                            // Spin Wheel Icon (clickable, FIXED: no white border)
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black54,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 32),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: const SpinWheelWidget(),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      'assets/images/Pngtreegolden_spin_wheel_4199603.png',
                                    ).image,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFAECBF9),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
