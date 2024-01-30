// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GradientLinearProgressIndicator extends StatefulWidget {
  final double progressValue;
  final double trackHeight;
  final double height;
  final Color backgroundColor;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;

  const GradientLinearProgressIndicator({
    super.key,
    required this.progressValue,
    required this.height,
    double? trackHeight,
    required this.backgroundColor,
    this.gradient,
    this.borderRadius,
  }) : trackHeight = trackHeight ?? height;

  @override
  _GradientLinearProgressIndicatorState createState() =>
      _GradientLinearProgressIndicatorState();
}

class _GradientLinearProgressIndicatorState
    extends State<GradientLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          Align(
            child: Container(
              width: size.width,
              height: widget.trackHeight,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: widget.borderRadius,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: size.width * widget.progressValue,
              height: widget.height,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: widget.borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
