import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/particle/particle_model.dart';

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration duration;
  Color color;

  ParticlePainter(this.particles, this.duration, {this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withAlpha(50);
    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(duration);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation['x'] * size.width, animation['y'] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
