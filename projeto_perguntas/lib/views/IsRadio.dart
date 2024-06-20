import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class OptionsListWidget<T> extends StatefulWidget {
  final List<T> options;
  final bool isRadio;
  final T? initialValue;
  final ValueChanged<T?> onChanged;

  const OptionsListWidget({
    super.key,
    required this.options,
    required this.isRadio,
    this.initialValue,
    required this.onChanged,
  });

  @override
  _OptionsListWidgetState<T> createState() => _OptionsListWidgetState<T>();
}

class _OptionsListWidgetState<T> extends State<OptionsListWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {

    if(widget.options.isEmpty){
     return Text("");
    }

    if(widget.isRadio){
      return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final option = widget.options[index];      
        return ListTile(
          title: Text(option.toString()),
          leading: Radio(
                  value: option,
                  groupValue: _selectedValue,
                  onChanged: (T? value) {
                    setState(() {
                      _selectedValue = value;
                      widget.onChanged(value);
                    });
                  },
                ) );}
      );
    }
    else
    {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final option = widget.options[index];      
        return ListTile(
          title: Text(option.toString()),
          leading: Checkbox(
                  value: _selectedValue == option,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedValue = option;
                      } else {
                        _selectedValue = null;
                      }
                      widget.onChanged(_selectedValue);
                    });
                  },
                )
                );
                }
      );      
    }

    /*return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final option = widget.options[index];      
        return ListTile(
          title: Text(option.toString()),
          leading: widget.isRadio
              ? Radio<T>(
                  value: option,
                  groupValue: _selectedValue,
                  onChanged: (T? value) {
                    setState(() {
                      _selectedValue = value;
                      widget.onChanged(value);
                    });
                  },
                )
              : Checkbox(
                  value: _selectedValue == option,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedValue = option;
                      } else {
                        _selectedValue = null;
                      }
                      widget.onChanged(_selectedValue);
                    });
                  },
                ),
        );
      },
    );*/
  }
}
