import 'dart:math' as Math;
import 'package:flutter/material.dart';

String timeAgo(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp).toLocal();
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} weeks ago';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} months ago';
  } else {
    return '${(difference.inDays / 365).floor()} years ago';
  }
}


LinearGradient parseLinearGradient(String cssGradient) {
  if(cssGradient.isEmpty) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Colors.white],
    );
  }
  final regex = RegExp(
    r'linear-gradient\((\d+)deg,\s*rgb\((\d+),\s*(\d+),\s*(\d+)\)\s*(\d+%)?,\s*rgb\((\d+),\s*(\d+),\s*(\d+)\)\s*(\d+%)?\)',
  );
  final match = regex.firstMatch(cssGradient);

  if (match != null) {
    final angle = int.parse(match.group(1)!) * Math.pi / 180; // Convert degrees to radians
    final color1 = Color.fromARGB(255, int.parse(match.group(2)!), int.parse(match.group(3)!), int.parse(match.group(4)!));
    final color2 = Color.fromARGB(255, int.parse(match.group(6)!), int.parse(match.group(7)!), int.parse(match.group(8)!));


    final stop1 = match.group(5) != null ? int.parse(match.group(5)!.replaceAll('%', '')) / 100.0 : 0.0;
    final stop2 = match.group(9) != null ? int.parse(match.group(9)!.replaceAll('%', '')) / 100.0 : 1.0;


    final x = Math.cos(angle);
    final y = Math.sin(angle);

    return LinearGradient(
      begin: Alignment(-x, -y), 
      end: Alignment(x, y),    
      colors: [color1, color2],
      stops: [stop1, stop2],   
    );
  } else {
    throw ArgumentError('Invalid CSS gradient format');
  }
}