// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:dx_flutter_demo/widgets/other/text_field.dart';

class CaseSummary extends StatelessWidget {
  final String status;
  final List primaryFields;
  final List secondaryFields;

  const CaseSummary(this.status, this.primaryFields, this.secondaryFields);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 15,
                      runSpacing: 10,
                      children: [
                        PhysicalShape(
                            elevation: 10.0,
                            color: const Color(0xFFDAF2E3),
                            clipper: const ShapeBorderClipper(
                                shape: ContinuousRectangleBorder()),
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(15, 12, 12, 10),
                                child: Text(status.toUpperCase(),
                                    style: const TextStyle(color: Color(0xFF006624))))),
                        ...primaryFields
                            .map(
                              (field) => PhysicalShape(
                                  elevation: 10.0,
                                  color: Colors.white,
                                  clipBehavior: Clip.antiAlias,
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.blue, width: 10),
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  child: Container(
                                      child: Column(children: [
                                    Container(
                                        color: const Color(0xFF295ED9),
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          field['name'],
                                          style: const TextStyle(color: Colors.white),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          field['value'] != null
                                              ? field['value'].toString()
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ))
                                  ]))),
                            )
                            .toList()
                      ]),
                )),
            Expanded(
              flex: 6,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 15.0,
                  runSpacing: 10.0,
                  children: secondaryFields
                      .map((field) =>
                          WrappedTextField(field['name'], field['value']))
                      .toList()),
            ),
          ],
        ));
  }
}
