import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_admin_page/widgets/widgets.dart';

class InputValidatorRule {
  final String errorMessage;
  final bool Function(String input) validator;

  InputValidatorRule({
    @required this.errorMessage,
    @required this.validator,
  });

  factory InputValidatorRule.require({@required String errorMessage}) {
    return InputValidatorRule(
      errorMessage: errorMessage,
      validator: (input) => input != null && input.isNotEmpty,
    );
  }
}

String _validate(String value, {List<InputValidatorRule> rules = const []}) {
  for (final rule in rules) {
    if (!rule.validator(value)) {
      return rule.errorMessage;
    }
  }

  return '';
}

class ValidatorInput extends StatefulWidget {
  final String title;
  final String placeholder;
  final String initialValue;
  final TextInputType keyboardType;
  final void Function(String value) onFieldSubmitted;
  final void Function(String value) onValid;
  final TextStyle titleStyle;
  final TextStyle titleBoldStyle;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final TextStyle errorTextStyle;
  final InputBorder enabledBorder;
  final InputBorder focusedBorder;
  final List<InputValidatorRule> validatorRules;
  final void Function(TextEditingController) onTextController;
  final bool showEmptySpaceForErrorMessage;
  final bool obscureText;
  final bool autofocus;
  final void Function(FocusNode) onFocusNode;
  final Iterable<String> autofilHints;

  const ValidatorInput({
    this.title = '',
    this.placeholder = '',
    this.initialValue = '',
    this.titleStyle,
    this.titleBoldStyle,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.keyboardType = TextInputType.text,
    this.validatorRules = const [],
    @required this.onValid,
    this.onFieldSubmitted,
    this.onTextController,
    this.showEmptySpaceForErrorMessage = true,
    this.obscureText = false,
    this.autofocus = false,
    this.onFocusNode,
    this.autofilHints = const [],
  });

  @override
  _ValidatorInputState createState() => _ValidatorInputState();
}

class _ValidatorInputState extends State<ValidatorInput> {
  TextEditingController _controller;
  var _errorMessage = '';
  var _touched = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_onChangeFocus);

    if (widget.onTextController != null) {
      widget.onTextController(_controller);
    }

    if (widget.onFocusNode != null) {
      widget.onFocusNode(_focusNode);
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onChangeFocus)
      ..dispose();

    super.dispose();
  }

  void _onChangeFocus() {
    if (!_focusNode.hasFocus) {
      _touched = true;
      _onChanged(_controller.text);
    }

    setState(() {});
  }

  void _onChanged(String value, {bool submit = false}) {
    _errorMessage = _validate(value, rules: widget.validatorRules);

    setState(() {});

    final validData = _errorMessage.isEmpty ? value : null;
    widget.onValid(validData);

    if (submit) {
      if (widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted(validData);
      }
    }
  }

  Widget _buildErrorMessage() {
    if (!widget.showEmptySpaceForErrorMessage && _errorMessage.isEmpty) {
      return const SizedBox();
    }

    return Text(_touched ? _errorMessage : '', style: widget.errorTextStyle);
  }

  void _onClear() {
    _controller.clear();

    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpanLabel(
          text: widget.title,
          defaultStyle: widget.titleStyle,
          boldStyle: widget.titleBoldStyle,
        ),
        const SizedBox(height: 8),
        TextFormField(
          autofocus: widget.autofocus,
          controller: _controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          autofillHints: widget.autofilHints,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: widget.hintStyle,
            enabledBorder: widget.enabledBorder,
            focusedBorder: widget.focusedBorder,
            contentPadding: const EdgeInsets.only(bottom: 6),
            isCollapsed: true,
            suffix: _focusNode.hasFocus && _controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: _onClear,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: AppIcon.closeCircle(),
                    ),
                  )
                : const SizedBox(height: 20),
          ),
          style: widget.textStyle,
          keyboardType: widget.keyboardType,
          onChanged: _onChanged,
          onFieldSubmitted: (value) => _onChanged(value, submit: true),
        ),
        _buildErrorMessage(),
      ],
    );
  }
}
