import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'dart:math' as math;

class StretchedSVGBetweenPoints extends StatelessWidget {
  final Offset start;
  final Offset end;
  final String svgAsset;
  final double height;
  final double width;
  



  const StretchedSVGBetweenPoints({
    super.key,
    required this.start,
    required this.end,
    required this.svgAsset,
    required this.height,
    required this.width  
  });

  @override
  Widget build(BuildContext context) {
    // Calcular vector entre puntos
    final vector = end - start;
    final distance = vector.distance;
    
    late final AnimationController _controller;

    final dx =  start.dx - end.dx;
    final dy =  start.dy - end.dy ;
    //final angle = atan2(dy, dx);

    //calculo del angulo
    final delta = end - start;
    final angle = delta.direction + (math.pi / 2);

    

    return 
            Transform.translate(
              offset: Offset(end.dx-width / 2,end.dy),
              child:
            
            Transform.translate(
                        offset: Offset(0,
                        0),
                        child:                
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..rotateZ(angle),                    
                          child: SvgPicture.asset(
                            svgAsset,
                            width: width,
                            height: height,
                          ),
                        ),
                      )
            );
              
   

  }
}