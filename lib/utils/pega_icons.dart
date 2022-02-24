// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

// little helper used to map Pega Cosmos Design System icon class names to the corresponding icon data

import 'package:flutter/cupertino.dart';

IconData getIconData(String iconName) {
  switch (iconName.split(' ').last) {
    case 'pi-home-solid':
      return const IconData(0xe17a, fontFamily: 'Pega');
    case 'flag':
      return const IconData(0xe066, fontFamily: 'Pega');
    case 'pi-users':
      return const IconData(0xe121, fontFamily: 'Pega');
    case 'pi-line-chart':
      return const IconData(0xe109, fontFamily: 'Pega');
    case 'pi-headline':
      return const IconData(0xe102, fontFamily: 'Pega');
    case 'pi-box-4':
      return const IconData(0xe037, fontFamily: 'Pega');
    case 'polaris-solid':
      return const IconData(0x5c, fontFamily: 'Pega');
    case 'pi-clipboard-medical':
      return const IconData(0xe076, fontFamily: 'Pega');
    case 'pi-check':
      return const IconData(0xe043, fontFamily: 'Pega');
    case 'pi-filter':
      return const IconData(0xe047, fontFamily: 'Pega');
    case 'pi-times':
      return const IconData(0xe1f4, fontFamily: 'Pega');
    case 'pi-search':
      return const IconData(0xe061, fontFamily: 'Pega');
    default:
      return const IconData(0xe218, fontFamily: 'Pega'); // pi-pegasus
  }
}
