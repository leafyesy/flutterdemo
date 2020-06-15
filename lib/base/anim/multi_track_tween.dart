import 'package:flutter/animation.dart';
import 'dart:math' as Math;

class MultiTrackTween extends Animatable<Map<String, dynamic>> {
  final _tracksToTween = Map<String, _TweenData>();

  var _maxDuration = 0;

  MultiTrackTween(List<Track> tracks)
      : assert(tracks != null),
        assert(
            tracks.where((element) => element.list.length == 0).length == 0) {
    _computeMaxDuration(tracks);
    _computeTrackTweens(tracks);
  }

  _computeMaxDuration(List<Track> tracks) {
    tracks.forEach((element) {
      final trackDuration = element.list
          .map((e) => e.duration.inMilliseconds)
          .reduce((value, element) => value + element);
      _maxDuration = Math.max(_maxDuration, trackDuration);
    });
  }

  _computeTrackTweens(List<Track> tracks) {
    tracks.forEach((element) {
      final trackDuration = element.list
          .map((e) => e.duration.inMilliseconds)
          .reduce((value, element) => value + element);
      final sequenceItems = element.list
          .map((e) => TweenSequenceItem(
              tween: e.tween, weight: e.duration.inMilliseconds / _maxDuration))
          .toList();
      if (trackDuration < _maxDuration) {
        sequenceItems.add(TweenSequenceItem(
            tween: ConstantTween(null),
            weight: (_maxDuration - trackDuration) / _maxDuration));
      }
      final sequence = TweenSequence(sequenceItems);
      _tracksToTween[element.name] =
          _TweenData(tween: sequence, maxTime: trackDuration / _maxDuration);
    });
  }

  Duration get duration {
    return Duration(milliseconds: _maxDuration);
  }

  @override
  Map<String, dynamic> transform(double t) {
    final Map<String, dynamic> result = Map();
    _tracksToTween.forEach((key, value) {
      final double tTween = Math.max(0, Math.min(t, value.maxTime - 0.0001));
      result[key] = value.tween.transform(tTween);
    });
    return result;
  }
}

class Track<T> {
  final String name;
  final List<_TrackItem> list = [];

  Track(this.name) : assert(name != null, "Name is Null");

  Track<T> add(Duration duration, Animatable<T> tween, {Curve curve}) {
    list.add(_TrackItem(duration, tween, curve: curve));
    return this;
  }
}

class _TrackItem<T> {
  final Duration duration;
  Animatable<T> tween;

  _TrackItem(this.duration, Animatable<T> tween, {Curve curve})
      : assert(duration != null),
        assert(tween != null) {
    if (curve == null) {
      this.tween = tween;
    } else {
      this.tween = tween.chain(CurveTween(curve: curve));
    }
  }
}

class _TweenData<T> {
  final Animatable<T> tween;
  final double maxTime;

  _TweenData({this.tween, this.maxTime});
}
