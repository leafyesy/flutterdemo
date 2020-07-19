import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/particle/particle_painter.dart';
import 'dart:math' as Math;

import 'package:flutter_demo/widget/particle/particle_model.dart';
import 'package:simple_animations/simple_animations/rendering.dart';

class ParticlesWidget extends StatefulWidget {
  final int numberOfParticles;

  const ParticlesWidget({Key key, this.numberOfParticles}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParticlesWidgetState();
  }
}

class _ParticlesWidgetState extends State<ParticlesWidget> {
  final Math.Random random = Math.Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    super.initState();
    List.generate(
        widget.numberOfParticles,
        (index) =>
            {particles.add(ParticleModel(random, defaultMilliseconds: 2000))});
  }

  _simulateParticles(Duration time) {
    particles.forEach((element) => element.maintainRestart(time));
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 50),
      onTick: (time) => _simulateParticles(time),
      builder: (context, time) {
        _simulateParticles(time);
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }
}
