import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:meta/meta.dart';

const double _kFlingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.currentCategory,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final Category currentCategory;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(47.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 50.0,
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(currentCategory.name,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
              ),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: ImageIcon(NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Menu%2C_Web_Fundamentals_%28White%29.svg/2000px-Menu%2C_Web_Fundamentals_%28White%29.svg.png')),
              ),
            ]),
          ),
        ),
        Stack(
          children: <Widget>[
            Semantics(
                label: 'hide categories menu',
                child: ExcludeSemantics(child: backTitle)),
          ],
        )
      ]),
    );
  }
}

class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Category currentCategory;

  const Backdrop(
      {@required this.currentCategory,
      @required this.frontLayer,
      @required this.backLayer})
      : assert(frontLayer != null),
        assert(backLayer != null),
        assert(currentCategory != null);

  @override
  State<StatefulWidget> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            currentCategory: widget.currentCategory,
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: _BackdropTitle(
            listenable: _controller.view,
            onPress: _toggleBackdropLayerVisibility,
            frontTitle: Image(image: AssetImage('images/main_logo_w.png')),
            backTitle: Image(image: AssetImage('images/main_logo_w.png')),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ));
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
