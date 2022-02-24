// Copyright 2022 Pegasystems Inc. All rights reserved.
// Use of this source code is governed by a Apache 2.0 license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class InputSelect extends StatelessWidget {
  final String label;
  final value;
  final List options;
  final void Function(String?) onChange;
  final bool required;

  const InputSelect(
      this.label, this.value, this.required, this.options, this.onChange);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (required == true && value!.isEmpty) {
          return 'field required';
        }
        return null;
      },
      value: value != '' ? value : null,
      icon: const Icon(Icons.arrow_downward),
      isDense: true,
      onChanged: onChange,
      items: options
          .map((option) => DropdownMenuItem(
                value: option['key'] as String,
                child: Text(option['value']),
              ))
          .toList(),
    );
  }
}
