import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'edit_accountpage_model.dart';
export 'edit_accountpage_model.dart';

class EditAccountpageWidget extends StatefulWidget {
  const EditAccountpageWidget({super.key});

  static String routeName = 'EditAccountpage';
  static String routePath = '/editAccountpage';

  @override
  State<EditAccountpageWidget> createState() => _EditAccountpageWidgetState();
}

class _EditAccountpageWidgetState extends State<EditAccountpageWidget>
    with TickerProviderStateMixin {
  late EditAccountpageModel _model;
  late Future<ApiCallResponse> profileResponse;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditAccountpageModel());
    profileResponse = ProfileCall.call(
      token: FFAppState().token,
      userId: FFAppState().userId,
    );
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textFieldFocusNode6 ??= FocusNode();

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
      'buttonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'buttonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF000B33),
        body: Container(
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
              begin: const AlignmentDirectional(0.17, -1),
              end: const AlignmentDirectional(-0.17, 1),
            ),
          ),
          child: FutureBuilder<ApiCallResponse>(
            future: profileResponse,
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
              final columnProfileResponse = snapshot.data!;

              return SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 35, 0, 0),
                            child: Text(
                              'MY Profile',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: const Color(0xFFFBD34D),
                                    fontSize: 24,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Builder(
                        builder: (context) {
                          if (_model.editPic) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      25, 10, 25, 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: const BoxDecoration(),
                                    child: ListView(
                                      padding: const EdgeInsets.fromLTRB(
                                        135,
                                        0,
                                        135,
                                        0,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '1';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '1'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '1'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/1.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '1')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '2';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '2'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '2'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/2.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '2')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '3';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '3'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '3'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/3.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '3')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '4';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '4'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '4'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/4.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '4')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '5';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '5'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '5'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/5.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '5')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '6';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '6'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '6'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/6.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '6')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '7';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '7'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '7'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/7.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '7')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '8';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '8'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '8'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/8.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '8')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                        Stack(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.icon = '9';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: _model.icon == '9'
                                                      ? 100.0
                                                      : 80.0,
                                                  height: _model.icon == '9'
                                                      ? 100.0
                                                      : 80.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFFF4CD2A),
                                                      width: 4,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 80,
                                                    height: 80,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/9.jpg',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (_model.icon == '9')
                                              FlutterFlowIconButton(
                                                borderRadius: 50,
                                                buttonSize: 30,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.check,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  size: 15,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                          ],
                                        ),
                                      ].divide(const SizedBox(width: 35)),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: Image.asset(
                                        'assets/images/bottomPanel.png',
                                      ).image,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 20, 0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.editPic = false;
                                          safeSetState(() {});
                                        },
                                        text: 'Done',
                                        icon: const FaIcon(
                                          FontAwesomeIcons.check,
                                          size: 18,
                                        ),
                                        options: FFButtonOptions(
                                          height: 30,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                          color: const Color(0x000B33FF),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          elevation: 0,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_model.icon == '1')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/1.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '2')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/2.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '3')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/3.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '4')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/4.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '5')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/5.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '6')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/6.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '7')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/7.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '8')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/8.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (_model.icon == '9')
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFF4CD2A),
                                            width: 4,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/9.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              150, 0, 0, 0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.editPic = true;
                                          safeSetState(() {});
                                        },
                                        text: 'Edit Icon',
                                        icon: const Icon(
                                          Icons.edit_sharp,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          height: 30,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                          color: const Color(0x000B33FF),
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          elevation: 0,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 2,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 20, 10, 0),
                              child: Container(
                                width: double.infinity,
                                height: 680,
                                decoration: BoxDecoration(
                                  color: const Color(0xBB08162C),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFF00CFFF),
                                  ),
                                ),
                            child:Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 15, 0, 0),
                                          child: Text(
                                            'Username',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      
                                   Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                        child:Container(
                                        width:
                                            MediaQuery.sizeOf(context).width <
                                                    350.0
                                                ? 260.0
                                                : 330.0,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          color: Color(0x33FFFFFF),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(-1, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(25, 0, 0, 0),
                                            child: Text(
                                              getJsonField(
                                                columnProfileResponse.jsonBody,
                                                r'''$.username''',
                                              ).toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                            ),
                                          ),
                                        ),
                                      ),
                                 ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Full Name',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 260.0
                                                : 330.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController1 ??=
                                                      TextEditingController(
                                                text: getJsonField(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                  r'''$.fullName''',
                                                ).toString(),
                                              ),
                                              focusNode:
                                                  _model.textFieldFocusNode1,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                hintText: 'TextField',
                                                hintStyle:
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
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController1Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Phone Number',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 0),
                                          child: SizedBox(
                                            width: 200,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController2 ??=
                                                      TextEditingController(
                                                text: getJsonField(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                  r'''$.phoneNumber''',
                                                ).toString(),
                                              ),
                                              focusNode:
                                                  _model.textFieldFocusNode2,
                                              autofocus: false,
                                              readOnly: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                hintText: 'TextField',
                                                hintStyle:
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
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
                                                fillColor: Colors.transparent,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController2Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Email',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 260.0
                                                : 330.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController3 ??=
                                                      TextEditingController(
                                                text: getJsonField(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                  r'''$.email''',
                                                ).toString(),
                                              ),
                                              focusNode:
                                                  _model.textFieldFocusNode3,
                                              autofocus: false,
                                              readOnly: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText: 'TextField',
                                                hintStyle:
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController3Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Date of Birth',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                     Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    // Text field (Expanded to prevent overflow)
    Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
        child: TextFormField(
          controller: _model.textController4 ??= TextEditingController(
            text: (getJsonField(
                      columnProfileResponse.jsonBody,
                      r'''$.dateofBirth''',
                    ) ??
                    '')
                .toString()
                .replaceAll('null', ''), // ✅ no "null"
          ),
          focusNode: _model.textFieldFocusNode4,
          autofocus: false,
          decoration: InputDecoration(
            isDense: true,
            // labelText: 'Date of Birth',
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
          readOnly: true, // ✅ prevent manual typing
          validator: _model.textController4Validator.asValidator(context),
        ),
      ),
    ),

    // Calendar icon (fixed size, no overflow)
    Container(
      width: 50,
      height: 47,
      margin: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: const Icon(Icons.calendar_month, size: 28),
        color: Colors.white,
        onPressed: () async {
          final datePickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: FlutterFlowTheme.of(context).primary,
                        onPrimary: FlutterFlowTheme.of(context).info,
                        surface:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        onSurface: FlutterFlowTheme.of(context).primaryText,
                      ),
                ),
                child: child!,
              );
            },
          );

          if (datePickedDate != null) {
            safeSetState(() {
              _model.datePicked = datePickedDate;
              _model.textController4?.text =
                  "${datePickedDate.day}-${datePickedDate.month}-${datePickedDate.year}";
            });
          }
        },
      ),
    ),
  ],
),

                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Gender',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 0),
                                          child: FlutterFlowChoiceChips(
                                            options: (getJsonField(
                                              columnProfileResponse.jsonBody,
                                              r'''$.gender''',
                                              true,
                                            ) as List?)!
                                                .map<String>(
                                                    (e) => e.toString())
                                                .toList()
                                                .cast<String>()
                                                .map((label) => ChipData(label))
                                                .toList(),
                                            onChanged: (val) => safeSetState(
                                                () => _model.choiceChipsValue =
                                                    val?.firstOrNull),
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
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
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              iconSize: 18,
                                              elevation: 0,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle:
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
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
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 18,
                                              elevation: 0,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            chipSpacing: 10,
                                            rowSpacing: 8,
                                            multiselect: false,
                                            initialized:
                                                _model.choiceChipsValue != null,
                                            alignment: WrapAlignment.start,
                                            controller: _model
                                                    .choiceChipsValueController ??=
                                                FormFieldController<
                                                    List<String>>(
                                              ['Male'],
                                            ),
                                            wrapped: true,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Country',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 260.0
                                                : 330.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController5 ??=
                                                      TextEditingController(
                                                text: getJsonField(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                  r'''$.country''',
                                                ).toString(),
                                              ),
                                              focusNode:
                                                  _model.textFieldFocusNode5,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText: 'TextField',
                                                hintStyle:
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController5Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(30, 20, 0, 0),
                                          child: Text(
                                            'Bio',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color:
                                                      const Color(0xFFFBD34D),
                                                  fontSize: 16,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 5, 0, 20),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                        .width <
                                                    350.0
                                                ? 260.0
                                                : 330.0,
                                            child: TextFormField(
                                              controller:
                                                  _model.textController6 ??=
                                                      TextEditingController(
                                                text: getJsonField(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                  r'''$.bio''',
                                                ).toString(),
                                              ),
                                              focusNode:
                                                  _model.textFieldFocusNode6,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText:
                                                    'Tell us about yourself...',
                                                hintStyle:
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
                                                          fontSize: 14,
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .textController6Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Click on the image to change your profile picture',
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 30, 0, 30),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    AccountpageWidget
                                                        .routeName);

                                                _model.soundPlayer ??=
                                                    AudioPlayer();
                                                if (_model
                                                    .soundPlayer!.playing) {
                                                  await _model.soundPlayer!
                                                      .stop();
                                                }
                                                _model.soundPlayer!
                                                    .setVolume(1);
                                                _model.soundPlayer!
                                                    .setAsset(
                                                        'assets/audios/click.mp3')
                                                    .then((_) => _model
                                                        .soundPlayer!
                                                        .play());
                                              },
                                              text: 'Cancel',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                                .width <
                                                            350.0
                                                        ? 130.0
                                                        : 150.0,
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
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
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
                                                    BorderRadius.circular(8),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'buttonOnPageLoadAnimation1']!),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                // Get the current user ID and token
                                                final userId =
                                                    FFAppState().userId;
                                                final token =
                                                    FFAppState().token;

                                                if (userId.isEmpty ||
                                                    token.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'User not authenticated'),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                  return;
                                                }

                                                // Show loading indicator
                                                final scaffold =
                                                    ScaffoldMessenger.of(
                                                        context);
                                                scaffold.showSnackBar(
                                                  const SnackBar(
                                                    content: Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .white),
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                            'Updating profile...'),
                                                      ],
                                                    ),
                                                    duration:
                                                        Duration(seconds: 5),
                                                  ),
                                                );

                                                try {
                                                  // Call the UpdateProfile API
                                                  final response =
                                                      await UpdateProfileCall
                                                          .call(
                                                    userId: FFAppState().userId,
                                                    token: FFAppState().token,
                                                    fullName: _model
                                                            .textController1
                                                            ?.text ??
                                                        '',
                                                    email: _model
                                                            .textController3
                                                            ?.text ??
                                                        '',

                                                    bio: _model.textController6
                                                            ?.text ??
                                                        '',
                                                    country: _model
                                                            .textController5
                                                            ?.text ??
                                                        '',
                                                    // Add other fields as needed
                                                  );

                                                  // Hide loading indicator
                                                  scaffold
                                                      .hideCurrentSnackBar();

                                                  if (response.succeeded) {
                                                    // Update app state with new user data if needed
                                                    FFAppState().userName =
                                                        _model.textController1
                                                                ?.text ??
                                                            '';

                                                    // Show success message
                                                    scaffold.showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Profile updated successfully!'),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    );
                                                    // Optionally navigate back
                                                    if (Navigator.canPop(
                                                        context)) {
                                                      Navigator.pop(context);
                                                    }
                                                  } else {
                                                    // Show error message
                                                    final errorMessage = response
                                                                .jsonBody
                                                                ?.isNotEmpty ==
                                                            true
                                                        ? (jsonDecode(response
                                                                    .jsonBody)[
                                                                'message'] ??
                                                            'Failed to update profile')
                                                        : 'Failed to update profile';
                                                    scaffold.showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text(errorMessage),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  }
                                                } catch (e) {
                                                  // Hide loading indicator
                                                  scaffold
                                                      .hideCurrentSnackBar();

                                                  // Show error message
                                                  scaffold.showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Error: ${e.toString()}'),
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                }
                                              },
                                              text: 'Save Changes',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                                .width <
                                                            350.0
                                                        ? 130.0
                                                        : 150.0,
                                                height: 40,
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(16, 0, 16, 0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
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
                                                    BorderRadius.circular(8),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'buttonOnPageLoadAnimation2']!),
                                          ].divide(const SizedBox(width: 10)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
      ),
    );
  }
}