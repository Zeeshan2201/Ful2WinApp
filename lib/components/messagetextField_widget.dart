import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'messagetextfield_model.dart';
export 'messagetextfield_model.dart';

class MessagetextfieldWidget extends StatefulWidget {
  const MessagetextfieldWidget({super.key});

  @override
  State<MessagetextfieldWidget> createState() => _MessagetextfieldWidgetState();
}

class _MessagetextfieldWidgetState extends State<MessagetextfieldWidget> {
  late MessagetextfieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessagetextfieldModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          child: TextFormField(
            controller: _model.textController,
            focusNode: _model.textFieldFocusNode,
            autofocus: false,
            obscureText: false,
            decoration: InputDecoration(
              isDense: true,
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
              hintText: 'TextField',
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            cursorColor: FlutterFlowTheme.of(context).primaryText,
            enableInteractiveSelection: true,
            validator: _model.textControllerValidator.asValidator(context),
          ),
        ),
      ],
    );
  }
}
