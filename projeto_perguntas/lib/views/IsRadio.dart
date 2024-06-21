import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class OptionsListWidget<T> extends StatefulWidget {
  final List<T> options;
  final bool isRadio;
  final T? initialValue;

  const OptionsListWidget({
    super.key,
    required this.options,
    required this.isRadio,
    this.initialValue,
  });

  @override
  _OptionsListWidgetState<T> createState() => _OptionsListWidgetState<T>();
}

class _OptionsListWidgetState<T> extends State<OptionsListWidget<T>> {
  T? _selectedValue;
  bool? checkBoxInitialValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    checkBoxInitialValue = false;
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
        bool? checkBoxValue = checkBoxInitialValue;      
        return ListTile(
          title: Text(option.toString()),
          leading: Checkbox(
                  value: checkBoxValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkBoxInitialValue = value!;
                      checkBoxValue = checkBoxInitialValue;
                      print(checkBoxInitialValue);
                    });
                  },
                )
                );
                }
      );      
    }
  }
}
