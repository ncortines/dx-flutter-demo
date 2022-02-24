// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

library assignment_form;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dx_flutter_demo/utils/dx_interpreter.dart';
import 'package:dx_flutter_demo/utils/dx_store.dart';

class AssignmentForm extends StatefulWidget {
  final ActionData actionData;
  final List<Widget> children;

  const AssignmentForm(this.actionData, this.children);

  @override
  AssignmentFormState createState() {
    return AssignmentFormState();
  }
}

class AssignmentFormState extends State<AssignmentForm> {
  final _formKey = GlobalKey<FormState>();
  late StreamSubscription buttonsSubscription;
  late StreamSubscription dxStoreSubscription;

  @override
  void initState() {
    // this extra logic allows to leverage floating buttons, which provide
    // better experience than layout-inline buttons
    buttonsSubscription =
        contextButtonActions.stream.listen((DxContextButtonAction action) {
      if (action == DxContextButtonAction.submit) {
        if (_formKey.currentState!.validate()) {
          dxStore.dispatch(ProcessAssignment(widget.actionData));
        }
      }
    });

    dxStoreSubscription = dxStore.onChange.listen((dxState) {
      final Map? errorData = dxState['lastError'];
      if (errorData != null) {
        final String title = errorData['errorClassification'];
        final String content = errorData.containsKey('errorDetails') &&
                errorData['errorDetails'] is List
            ? errorData['errorDetails'].fold(
                '',
                (message, errorDetail) =>
                    message + errorDetail['localizedValue'] + '\n')
            : '';

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  FlatButton(
                    child: const Text('OK'),
                    onPressed: () {
                      dxStore.dispatch(const RemoveError());
                      dxStore.dispatch(const ToggleCustomButtonsVisibility(
                          {DxContextButtonAction.submit: true}));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    buttonsSubscription.cancel();
    dxStoreSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dxStore.dispatch(
        const ToggleCustomButtonsVisibility({DxContextButtonAction.submit: true}));
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 10),
        child: Text(widget.actionData.name!,
            style: Theme.of(context).textTheme.titleMedium),
      ),
      const Divider(),
      Container(
        padding: const EdgeInsets.fromLTRB(7, 1, 7, 10),
        child: Form(
            key: _formKey,
            child: Column(
              children: widget.children,
            ))
      )
    ]);
  }
}
