import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedDice extends StatefulWidget {
  final Function(int) onRolled;

  const AnimatedDice({super.key, required this.onRolled});

  @override
  State<AnimatedDice> createState() => _AnimatedDiceState();
}

class _AnimatedDiceState extends State<AnimatedDice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _diceValue = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0, end: pi * 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Al final de la animación, generar valor y notificar
        final newValue = Random().nextInt(6) + 1;
        //setState(() => _diceValue = newValue);
        
        _diceValue = newValue;
        widget.onRolled(_diceValue);
      }
    });
  }

  void rollDice() {
    _controller.reset();
    _controller.forward();//inicia la animacion
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDiceFace(int value) {
    // O puedes usar imágenes: Image.asset('assets/dice_$value.png')
    /*return Text(
      '$value',
      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    );*/
    return Image.asset('assets/images/dice_$value.png');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
        onTap: rollDice, // Ejecuta animación al tocar
        child:

        AnimatedBuilder(
          animation: _animation,//el objeto que anima el dice
          builder: (context, child) {
            return Transform.rotate(
              angle: _animation.value,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                ),                
                child: Center(
                    child: ClipRRect(
                          
                          child: Image.asset('assets/images/dice_$_diceValue.png')),//_buildDiceFace(_diceValue)
                    ),
                  
              ),
            );
          },
        ),
        ),
        /*const SizedBox(height: 10),
        ElevatedButton(
          onPressed: rollDice,
          child: const Text('Lanzar'),
        ),*/
      ],
    );
  }
}