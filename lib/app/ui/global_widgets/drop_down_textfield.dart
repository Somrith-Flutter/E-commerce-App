import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:market_nest_app/app/ui/global_widgets/my_textInput.dart';
import 'package:market_nest_app/app/ui/global_widgets/text_widget.dart';

enum Mode { menu, dialog }

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
// const double _kMenuMaxWidth = 6.5 * _kMenuWidthStep;
const double _kMenuMinWidth = 4.0 * _kMenuWidthStep;
const double _kMenuWidthStep = 56.0;

class ExDropdownTextfield<T> extends StatefulWidget {
  const ExDropdownTextfield({
    super.key,
    this.label,
    this.prefixIcon,
    this.items = const [],
    this.itemBuilder,
    this.itemAsString,
    this.controller,
    this.readOnly = false,
    this.noBorder = false,
    this.onSelectedChange,
    this.hasFilled = true,
    this.textColor,
    this.isRequired = false,
    this.xLabel,
    this.enabled = true,
    this.isLoading = false,
    this.errorText,
    this.ignoreCurrent = false,
    this.visibilityCount,
    this.suffixIcon,
    this.onSearch,
  });

  final String? label;
  final Widget? prefixIcon;
  final List<T> items;

  final Widget Function<T>(T it)? itemBuilder;
  final String Function(T item)? itemAsString;
  final DropDownTextFieldController<T>? controller;
  final bool readOnly;
  final bool noBorder;
  final void Function(T item)? onSelectedChange;
  final bool hasFilled;
  final Color? textColor;
  final bool isRequired;
  final String? xLabel;
  final bool enabled;
  final bool isLoading;
  final String? errorText;
  final Widget? suffixIcon;

  /// Search bar
  final List<T> Function(String item)? onSearch;

  /// List item length that would be visually render
  final int? visibilityCount;

  /// When current item is being select again, [onSelectedChange] won't trigger.
  ///
  /// Default to `false`
  final bool ignoreCurrent;

  @override
  State<ExDropdownTextfield<T>> createState() => _ExDropdownTextfieldState<T>();
}

class _ExDropdownTextfieldState<T> extends State<ExDropdownTextfield<T>> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    widget.controller?.onSetSelectedItem = _setSelectedItem;

    if (widget.controller?.selectedItem != null) {
      _setSelectedItem(widget.controller?.selectedItem);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyTextInput(
      label: widget.label,
      xLabel: widget.xLabel,
      prefixIcon: widget.prefixIcon,
      controller: _textEditingController,
      enabled: widget.enabled, //&& widget.items.isNotEmpty,
      readOnly: true,
      // Disable auto text selection when item choosen.
      enableInteractiveSelection: false,
      suffixIcon: widget.isLoading
          ? const SizedBox(
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
            )
          : widget.suffixIcon ??
              Icon(
                Icons.expand_more_outlined,
                color: widget.textColor,
              ),
      isRequired: widget.isRequired,
      onTap: () {
        if (widget.readOnly) return;
        if (widget.items.isEmpty) return;
        _openMenu();
      },
      errorText: widget.errorText,
    );
  }

  void _setSelectedItem(T? it) {
    widget.controller?.selectedItem = it;
    if (it == null) {
      _textEditingController.clear();
      return;
    }
    if (widget.itemAsString != null) {
      _textEditingController.text = widget.itemAsString!(it);
    } else {
      _textEditingController.text = it.toString();
    }
  }

  Future _openMenu() async {
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    var result = await showCustomMenu(
      context: context,
      position: (_position)(
        popupButtonObject,
        overlay,
      ),
      //child: _popupWidgetInstance(),
    );

    if (result != null) {
      if (widget.ignoreCurrent) {
        if (widget.controller != null &&
            widget.controller!.selectedItem == result) {
          return;
        }
      }
      _setSelectedItem(result);
      if (widget.onSelectedChange != null) {
        widget.onSelectedChange!(result);
      }

      // if (widget.itemAsString != null) {
      //   var str = widget.itemAsString!(result);
      //   _textEditingController.text = str;
      // } else {
      //   _textEditingController.text = result.toString();
      // }
    }
    return result;
  }

  Future<T?> showCustomMenu({
    required BuildContext context,
    required RelativeRect position,
    //required Widget child,
  }) {
    final NavigatorState navigator = Navigator.of(context);
    return navigator.push(
      _PopupMenuRoute<T>(
        context: context,
        position: position,
        items: widget.items,
        visibleCount: widget.visibilityCount,
        // search: widget.onSearch,
        onSearch: widget.onSearch,
        itemBuilder: (x) {
          if (widget.itemBuilder != null) {
            return widget.itemBuilder!(x);
          }

          return ListTile(
            title: TextWidget(
              widget.itemAsString != null
                  ? widget.itemAsString!(x)
                  : x.toString(),
              size: 16,
            ),
            dense: true,
            onTap: () {
              Navigator.of(context).pop(x);
            },
          );

          //TextWidget(x.toString());
        },
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        capturedThemes: InheritedTheme.capture(
          from: context,
          to: navigator.context,
        ),
      ),
    );
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    required this.context,
    required this.position,
    required this.capturedThemes,
    required this.barrierLabel,
    this.items = const [],
    required this.itemBuilder,
    this.visibleCount,
    this.search,
    this.onSearch,
  });

  final BuildContext context;
  final RelativeRect position;
  final List<T> items;
  final Widget Function(T it) itemBuilder;
  final int? visibleCount;
  final void Function(String item)? search;
  final List<T> Function(String item)? onSearch;

  final CapturedThemes capturedThemes;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget menu = _PopupMenu<T>(
      route: this,
      semanticLabel: "",
      constraints: null,
      items: items,
      itemBuilder: itemBuilder,
      visibleCount: visibleCount,
      search: search,
      onSearch: onSearch,
    );
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupMenuRouteLayout(context, position),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;
  final BuildContext context;

  _PopupMenuRouteLayout(
    this.context,
    this.position,
  );

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final parentRenderBox = context.findRenderObject() as RenderBox;
    //keyBoardHeight is height of keyboard if showing
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    double safeAreaTop = MediaQuery.of(context).padding.top;
    double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    double totalSafeArea = safeAreaTop + safeAreaBottom;
    double maxHeight = constraints.minHeight - keyBoardHeight - totalSafeArea;
    return BoxConstraints.loose(
      Size(
        parentRenderBox.size.width - position.right - position.left,
        maxHeight,
      ),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    //keyBoardHeight is height of keyboard if showing
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    double x = position.left;

    // Find the ideal vertical position.
    double y = position.top;
    // check if we are in the bottom
    if (y + childSize.height > size.height - keyBoardHeight) {
      y = size.height - childSize.height - keyBoardHeight;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return true;
  }
}

class _PopupMenu<T> extends StatefulWidget {
  const _PopupMenu({
    super.key,
    required this.route,
    required this.semanticLabel,
    required this.itemBuilder,
    this.items = const [],
    this.bgColor,
    this.constraints,
    this.visibleCount,
    this.search,
    this.onSearch,
  });

  final List<T> items;
  final Widget Function(T it) itemBuilder;
  final Color? bgColor;

  final _PopupMenuRoute<T> route;
  final String? semanticLabel;
  final BoxConstraints? constraints;
  final int? visibleCount;
  final void Function(String item)? search;
  final List<T> Function(String item)? onSearch;

  @override
  State<_PopupMenu<T>> createState() => _PopupMenuState<T>();
}

class _PopupMenuState<T> extends State<_PopupMenu<T>> {
  late TextEditingController textController;

  late List<T> items;
  // Temp items for search purpose
  List<T> tmpItems = [];
  // Search key
  String searchTxt = '';

  @override
  void initState() {
    textController = TextEditingController();
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 /
        (items.length +
            1.5); // 1.0 for the width and 0.5 for the last item's fade.
    final List<Widget> children = <Widget>[];
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    for (int i = 0; i < items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: widget.route.animation!,
        curve: Interval(start, end),
      );

      Widget item = widget.itemBuilder(items[i]);

      children.add(FadeTransition(
        opacity: opacity,
        child: item,
      ));
    }

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: Interval(0.0, unit));
    final CurveTween height =
        CurveTween(curve: Interval(0.0, unit * items.length));

    final Widget child = ConstrainedBox(
        constraints: widget.constraints ??
            const BoxConstraints(
              minWidth: _kMenuMinWidth,
              // maxWidth: _kMenuMaxWidth,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));

    // Amount of visible item rendering on list box
    int visibleCount = widget.visibleCount ?? (widget.search != null ? 6 : 5);
    // Each item height
    double itemHeight = 40;
    final menuHeight = itemHeight * visibleCount;

    return AnimatedBuilder(
      animation: widget.route.animation!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: opacity.animate(widget.route.animation!),
            child: Material(
              shape: popupMenuTheme.shape,
              color: widget.bgColor ?? popupMenuTheme.color,
              borderRadius: BorderRadius.circular(8),
              type: MaterialType.card,
              elevation: 2,
              shadowColor: Theme.of(context).colorScheme.shadow,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                widthFactor: width.evaluate(widget.route.animation!),
                heightFactor: height.evaluate(widget.route.animation!),
                child: SizedBox(
                  height: menuHeight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _searhBar(),
                      Flexible(
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            primary: true,
                            child: FadeTransition(
                              opacity: opacity.animate(widget.route.animation!),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
      child: child,
    );
  }

  Widget _searhBar() {
    if (widget.onSearch != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchTFWidget(
          controller: textController,
          isLoading: false,
          width: double.infinity,
          onChanged: (val) {
            searchTxt = val;
            tmpItems = widget.onSearch!(val);
            items = tmpItems;
            setState(() {});
          },
        ),
      );
    }
    return const SizedBox();
  }

  @override
  void dispose() {
    textController.clear();
    super.dispose();
  }
}


class DropDownTextFieldController<T> {
  T? selectedItem;

  ///Value from ItemAsString
  String Function(T it)? getDisplayValue;
  void Function(T? it)? onSetSelectedItem;

  ///
  /// Run timer
  ///
  setSelectedItem(T? it) {
    selectedItem = it;
    if (onSetSelectedItem != null) {
      onSetSelectedItem!(it);
    }
  }
}

class SearchTFWidget extends StatelessWidget {
  const SearchTFWidget({
    super.key,
    required this.controller,
    this.onChanged,
    required this.isLoading,
    this.width,
    this.title,
    this.hintText,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isLoading;
  final double? width;
  final String? title;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width ?? 250),
      child: MyTextInput(
        controller: controller,
        onChanged: onChanged,
        label: title ?? 'Search',
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        debounce: const Duration(milliseconds: 500),
        isLoading: isLoading,
        clearTextBtn: true,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
