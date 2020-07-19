import 'dart:math';
import 'package:flutter/material.dart';

class CustomBouncingScrollPhysics extends ScrollPhysics {
  final double refreshHeight;

  const CustomBouncingScrollPhysics(
      {ScrollPhysics parent, this.refreshHeight = 140})
      : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  double frictionFactor(double overscrollFraction) =>
      0.52 * pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);
    if (!position.outOfRange) return offset;
    final double overscrollPastStart =
        max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd =
        max(position.pixels - position.maxScrollExtent, 0.0);

    final double overscrollPast = max(overscrollPastStart, overscrollPastEnd);

    final bool easing = (overscrollPastStart > 0.0 && offset < 0) ||
        (overscrollPastEnd > 0 && offset > 0.0);
    final double friction = easing
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;
    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutsize, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutsize > 0) {
      final double deltaToLimit = extentOutsize / gamma;
      if (absDelta < deltaToLimit) return absDelta * gamma;
      total += extentOutsize;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    return 0.0;
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity * 0.91,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  double get minFlingVelocity => 50.0 * 2.0;

  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        min(0.000816 * pow(existingVelocity.abs(), 1.967).toDouble(), 40000.0);
  }

  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}
