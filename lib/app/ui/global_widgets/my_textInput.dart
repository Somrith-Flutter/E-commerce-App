import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextInput extends StatefulWidget {
  const MyTextInput({
    super.key,
    this.label,
    this.onChanged,
    this.errorText,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardType,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.isRequired = false,
    this.obscureText = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.initialValue,
    this.onTap,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.hintText,
    this.fillColor,
    this.textAlign = TextAlign.start,
    this.textSize,
    this.maxLines = 1,
    this.maxLength,
    this.xLabel,
    this.xBold = false,
    this.validator,
    this.onUpload,
    this.onDeleted,
    this.isLoading = false,
    this.filled = false,
    this.viewOnly = false,
    this.debounce,
    this.enableInteractiveSelection,
    this.clearTextBtn,
    this.xSize = 16,
  });

  final String? label;
  final void Function(String value)? onChanged;
  final String? errorText;
  final void Function(String value)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? prefixText;
  final Widget? suffixIcon;
  final String? suffixText;
  final bool isRequired;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final bool enabled;
  final FocusNode? focusNode;
  final String? initialValue;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Color? fillColor;
  final TextAlign textAlign;
  final double? textSize;
  final int? maxLines;
  final int? maxLength;
  final String? xLabel;

  /// set bold text to xLabel
  final bool xBold;
  final String? Function(String text)? validator;
  final void Function()? onUpload;
  final void Function()? onDeleted;
  final double xSize;

  final bool? clearTextBtn;

  /// Show loading indicator at suffix when true
  final bool isLoading;
  final bool filled;

  /// Give some delay to when onChanged trigger after text changed.
  final Duration? debounce;
  final bool? enableInteractiveSelection;

  /// upload or delete icon will not showup
  /// user can only use [onTap].
  final bool viewOnly;

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    if (_debounceTimer != null) {
      _debounceTimer?.cancel();
    }
    super.dispose();
  }

  void _onTextChanged(String value) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(widget.debounce ?? const Duration(seconds: 0), () {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        width: 1,
        color: Theme.of(context).dividerColor.withOpacity(0.3),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.xLabel != null)
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: widget.xLabel,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: widget.xBold ? FontWeight.bold : null,fontSize: widget.xSize,
                    ),
              ),
              if (widget.isRequired)
                TextSpan(
                  text: ' *',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.red),
                ),
              // For unbalance character height cause by font
              const WidgetSpan(child: SizedBox(height: 26)),
            ]),
          ),
        const SizedBox(height: 4),
        TextFormField(
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(value!);
            }

            if (widget.isRequired && value!.isEmpty) {
              return 'Please enter${widget.label ?? widget.xLabel ?? ''}';
            }

            return null;
          },
          controller: widget.controller,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          initialValue: widget.initialValue,
          onChanged: _onTextChanged,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          autofocus: widget.autoFocus,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          style: widget.enabled
              ? _enabledTextStyle(context)
              : _disabledTextStyle(context),
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            counterText: '',
            hintText: widget.hintText,
            hintStyle: _disabledTextStyle(context),
            labelText: widget.label != null
                ? widget.label! + (widget.isRequired ? ' *' : '')
                : null,
            prefixStyle: widget.enabled
                ? _enabledTextStyle(context)
                : _disabledTextStyle(context),
            fillColor: widget.filled
                ? Theme.of(context).dividerColor.withOpacity(.1)
                : null,
            filled: widget.filled,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            prefixIcon: widget.prefixIcon,
            prefixText: widget.prefixText,
            suffixIcon: _suffixIcon(),
            suffixText: widget.suffixText,
            errorText: widget.errorText,
          ),
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
        ),
      ],
    );
  }

  Widget? _suffixIcon() {
    if (widget.viewOnly && !widget.isLoading) return null;

    if (widget.isLoading) {
      return const SizedBox(
        width: 8,
        height: 8,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    if (widget.onUpload != null && widget.clearTextBtn != null) {
      throw Exception(
          'onUpload and onSearch cannot be both use at the same times.');
    }

    if (widget.onUpload != null) {
      if (widget.controller != null &&
          widget.controller?.text.isNotEmpty == true) {
        return IconButton(
          onPressed: () {
            widget.controller!.clear();
            if (widget.onDeleted != null) {
              widget.onDeleted!();
            }
            setState(() {});
          },
          icon: const Icon(Icons.delete_rounded, color: Colors.red),
        );
      }

      return IconButton(
        onPressed: widget.onUpload,
        icon: const Icon(Icons.file_open_rounded),
      );
    }

    if (widget.clearTextBtn == true) {
      if (widget.controller != null &&
          (widget.controller?.text.isNotEmpty ?? false)) {
        return IconButton(
          onPressed: () {
            widget.controller?.clear();
            widget.onChanged!(widget.controller!.text);
            setState(() {});
          },
          icon: const Icon(Icons.close_rounded),
        );
      }
    }

    if (widget.suffixIcon != null) {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: widget.suffixIcon,
        ),
      );
    }
    return null;
  }

  TextStyle _enabledTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: widget.textSize,
        );
  }

  TextStyle _disabledTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).disabledColor,
          fontSize: widget.textSize,
        );
  }
}
