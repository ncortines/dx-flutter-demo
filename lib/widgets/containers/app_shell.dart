// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:dx_flutter_demo/utils/dx_interpreter.dart';
import 'package:dx_flutter_demo/utils/dx_store.dart';
import 'package:dx_flutter_demo/utils/pega_icons.dart';
import 'package:dx_flutter_demo/widgets/factory.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';

class AppShell extends StatelessWidget {
  final String appName;
  final String pathContext;
  final List pages;
  final List caseTypes;

  const AppShell(this.appName, this.pathContext, this.pages, this.caseTypes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(appName, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1F2555),
        ),
        floatingActionButton: StoreConnector<
                UnmodifiableMapView<String, dynamic>,
                UnmodifiableMapView<String, dynamic>>(
            converter: (dxStore) => getContextButtonsVisibility(dxStore.state),
            distinct: true,
            builder: (context, Map contextButtonsVisibility) {
              if (contextButtonsVisibility[
                      DxContextButtonAction.submit.toString()] ==
                  true) {
                return FloatingActionButton(
                  onPressed: () =>
                      contextButtonActions.add(DxContextButtonAction.submit),
                  child: Icon(getIconData('pi-check')),
                  backgroundColor: Colors.green,
                );
              }
              if (contextButtonsVisibility[
                      DxContextButtonAction.filter.toString()] ==
                  true) {
                return FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: Icon(getIconData('pi-filter')),
                  backgroundColor: Colors.green,
                );
              }
              return Container(width: 0, height: 0);
            }),
        body: StoreConnector<UnmodifiableMapView<String, dynamic>,
                UnmodifiableMapView<String, dynamic>>(
            converter: (dxStore) => getCurrentPage(),
            distinct: true,
            builder: (context, node) {
              final root = getRootNode(node);
              return getWidget(root, context, getUpdatedPathContext(pathContext, root))!;
            }),
        drawer: Drawer(
            child: Container(
                color: const Color(0xFF262626),
                child: SafeArea(
                    child: ListView(padding: EdgeInsets.zero, children: [
                  Container(
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: SvgPicture.asset(
                                    'assets/images/pega.svg',
                                    color: Colors.white,
                                  )),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Space Travel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(color: Colors.white)),
                                  )
                                ]),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Container(
                                  decoration: const ShapeDecoration(
                                      color: Color(0xFFCFD1E6),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)))),
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            isDense: true,
                                            icon:
                                                Icon(getIconData('pi-search')),
                                            border: InputBorder.none,
                                            hintText: 'Search...',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color:
                                                        const Color(0xFF919191),
                                                    fontStyle:
                                                        FontStyle.italic)),
                                      ))))
                        ])),
                  ),
                  const Divider(color: Color(0xFF383838)),
                  ExpansionTile(
                      backgroundColor: const Color(0xFF383838),
                      leading: const Icon(Icons.add, color: Color(0xFF919191)),
                      title: Text('Create',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: const Color(0xFF919191))),
                      children: caseTypes
                          .map((caseType) => ListTile(
                              leading: Text(''),
                              title: Text(caseType['pyLabel'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          color: const Color(0xFF919191))),
                              onTap: () {
                                Navigator.pop(context);
                                dxStore.dispatch(CreateAssignment(
                                    caseType['pyClassName'],
                                    caseType['pyFlowType']));
                              }))
                          .toList()),
                  ...pages
                      .map((page) => ListTile(
                          leading: Icon(
                            getIconData(page['pxPageViewIcon']),
                            color: const Color(0xFF919191),
                          ),
                          title: Text(page['pyLabel'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: const Color(0xFF919191))),
                          onTap: () {
                            Navigator.pop(context);
                            dxStore.dispatch(FetchPage(
                                page['pyRuleName'], page['pyClassName']));
                          }))
                      .toList()
                ])))));
  }
}
