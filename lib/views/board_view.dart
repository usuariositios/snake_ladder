import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/model/Ladder.dart';
import 'package:snake_ladder1/model/LadderPositions.dart';
import 'package:snake_ladder1/model/Snake.dart';
import 'package:snake_ladder1/model/SnakePositions.dart';
import 'package:snake_ladder1/widgets/Ladder_painter.dart';
import 'package:snake_ladder1/widgets/animated_dice.dart';
import 'package:snake_ladder1/widgets/animated_player.dart';
import 'package:snake_ladder1/widgets/comic_mensaje.dart';
import 'package:snake_ladder1/widgets/strechedSVG.dart';




import '../controllers/board_controller.dart';
import 'dart:ui' as ui;

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  final BoardController controller = Get.put(BoardController());
  final AnimatePlayerController apController = Get.put(AnimatePlayerController());
  
  

  

@override
void initState() {
  super.initState();
  
  
  
  
  WidgetsBinding.instance.addPostFrameCallback((_) {
    
      WidgetsBinding.instance.addPostFrameCallback((_) {

        WidgetsBinding.instance.addPostFrameCallback((_) {//luego que se dibujen los widgets
        
        controller.calculateTilePositions();//calcula posicion de los widgets del tablero

        //colocar las posiciones de los jugadores
        for(int i=0;i<controller.playersList.length;i++){
          controller.playersList[i].posicion = controller.getTilePosition1(controller.numberDice.value).obs;//colocar posiciones luego de dibujar el screen
          
        }

        //controller.playersList[0].posicion = controller.getTilePosition1(controller.numberDice1.value).obs;//inicializacion de jugadores
        //controller.playersList[1].posicion = controller.getTilePosition1(controller.numberDice2.value).obs;

        });
        
      });
  });

  /*loadSnakeHeadImage().then((img) {
    setState(() {
      controller.snakeImage = img;
      controller.isImageLoaded.value = true;
    });
  });*/

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: 
      Column(
          children: [
            //const SizedBox(height: 40),
            Expanded(child: 
      Stack(
        children: [
          // 🧱 Grid de casillas
          
          GridView.builder(
            //padding: const EdgeInsets.all(20),
            itemCount: controller.boardSize,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,//numero de casillas a la horizontal y vertical
            ),
            itemBuilder: (context, index) {
              //final tileNumber = 100 - index;
              return Container(
                key: controller.tileKeys[index],
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.grey),
                  color: controller.indiceList[index].color                  
                ),
                child: Center(child: Text('${controller.indiceList[index].indice}',style: TextStyle(color: Colors.white,)),),//$tileNumber controller.indiceList[index]
                
              );
            },
          ),
          

          // 🎯 Dibujo personalizado (jugadores, serpientes, escaleras)
          /*Obx(() {
            if (controller.tilePositions.isEmpty) return const SizedBox();
            return Positioned.fill(
              child: CustomPaint(
                painter: BoardPainter(controller.tilePositions),
              ),
            );
          }),*/

        
        Obx((){
            if (controller.positionsList.isEmpty || controller.snakePositionsList.isEmpty) return const SizedBox();

            
            /*final from = controller.getTilePosition1(100);
            final to = controller.getTilePosition1(21);
            Snake(from: from, to: to)*/
            
            for(SnakePositions sp in controller.snakePositionsList){
              controller.snakeList.add(Snake(from: controller.getTilePosition1(sp.ubicIni??0), to: controller.getTilePosition1(sp.ubicFin??0),assets: sp.assets??""));
            }

            /*List<Snake> snakeList = [
                      Snake(from: controller.getTilePosition1(21), to: controller.getTilePosition1(91)),
                      Snake(from: controller.getTilePosition1(7), to: controller.getTilePosition1(40)),
                      Snake(from: controller.getTilePosition1(15), to: controller.getTilePosition1(57)),
                      // agrega más aquí
                  ];*/
            
            /*return Positioned.fill(
              child: IgnorePointer(
                child: RepaintBoundary(
                child:CustomPaint(//evita que se repinten los snakes dentro de obx
                  painter:   SnakePainter(snakeList),
                )),
              ),
            );*/

            return const SizedBox();
          }),
          Obx(() {
            if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();
            List<Ladder> ladderList = [];
            for(LadderPositions lp in controller.ladderPositionsList){
              ladderList.add(Ladder(from: controller.getTilePosition1(lp.ubicIni??0), to: controller.getTilePosition1(lp.ubicFin??0),pasos: lp.pasos??0));
            }          
          return RepaintBoundary(
            child:CustomPaint(
              painter: LadderPainter(
                ladderList
              ),
                size: Size.infinite,
              )
            );
          }),      
         /*Obx(() {
          return Positioned(
            left: controller.getTilePosition1(controller.numberDice.value).dx-10 ,
            top: controller.getTilePosition1(controller.numberDice.value).dy-17,
            child: Image.asset(
              'assets/images/player.png',
              width: 20,
              height: 35,
            ),
          );           
         }),*/
         /*Obx(() {
          if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();          
          return Positioned(
            left: controller.playersList[0].posicion.value.dx-10,
            top: controller.playersList[0].posicion.value.dy-17,
            child: Image.asset(
              'assets/images/player.png',
              width: 20,
              height: 35,
            ),
          );
          }), 

          Obx(() {
          if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();          
          return Positioned(
            left: controller.playersList[1].posicion.value.dx-10,
            top: controller.playersList[1].posicion.value.dy-17,
            child: Image.asset(
              'assets/images/player.png',
              width: 20,
              height: 35,
            ),
          );
          }),*/

          Obx(() {
          if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();          
          return Stack(
            children: controller.playersList.map((player){
             return Positioned(
                left: player.posicion.value.dx-10,
                top: player.posicion.value.dy-17,
                child: Image.asset(
                  'assets/images/player_${player.colorPlayers}.png',
                  width: 20,
                  height: 35,
                ),
              );
            }).toList()
          );
          
          }),



          
         /*Obx(() {
          if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();          
          return SnakeHead(
            position: controller.getTilePosition1(38),
            width: 20,
            height: 20,
            angle:0.5,
            headColor: Colors.green,
            eyeColor: Colors.black,
          );

          }), */

          /*Obx((){
            if(controller.isImageLoaded.isFalse) return const SizedBox();
              final from = controller.getTilePosition1(10);
              final to = controller.getTilePosition1(91);
              

              return CustomPaint(
                size: Size.infinite,
                painter: VerticalImagePainter(
                  image: controller.snakeImage,
                  from: from,
                  to:to
                ),
              );
          })*/
          /*Obx(() {
            if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();
          return VerticalSvgPositioner(
            start: controller.getTilePosition1(75),
            end: controller.getTilePosition1(48),
            svgHeight: 586,  // Altura original del SVG
            svgAsset: 'assets/images/snake.svg',
            debugColor: Colors.red,
            );
          }),*/

         
          Obx(() {
            if (controller.positionsList.isEmpty || controller.ladderPositionsList.isEmpty) return const SizedBox();
            return Stack(
            children: controller.snakeList.map((snake){

                return  StretchedSVGBetweenPoints(
                start: snake.from,
                end: snake.to,
                svgAsset: snake.assets, //'assets/images/snake.svg'
                height: (snake.from-snake.to).distance,
                width: 50,);

                }).toList()
            );
              
          }),
          Obx(() {
            return Stack(
              children: apController.mensajeList
                  .map((msg) => ComicMensaje(
                        texto: msg.texto,
                        offset: msg.offset,
                        color: msg.color,
                        piquitoIzquierda: msg.piquitoIzquierda,
                        onCerrar: () {
                          controller.cerrarMensaje(msg);
                                       },
                      ))
                  .toList(),
            );
          }),
            
        ],
       ),
      ),
      /*Obx(() { return 

      Text('(Turno de ${controller.playersList[controller.turnoPlayerx.value].nombre})');


      })
      ,*/
      
        Obx(() =>
        AbsorbPointer(
          absorbing: controller.disableDice.value,
          child:
          
        AnimatedDice(
          onRolled: (value) {//devuelve el valor
            //controller.actualizaPosicion(value);
            //await Future.delayed(Duration(milliseconds: 100)); // pequeña pausa entre saltos
            apController.mensajeList.clear();
            controller.iniciarSalto(value);//para el player2
            
            //controller.numberDice.value += value;
            //controller.player1.value.numUbic += value;
            //print('posicion player : ${controller.player1.value.numUbic}');
          },
        )        
        ),                
      ),
      SizedBox(height: 90),
        
      ]),
      
    );
  }

Future<ui.Image> loadSnakeHeadImage() async {
  final data = await rootBundle.load('assets/images/snake.png');
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
  }
}

class BoardPainter extends CustomPainter {
  final List<Offset> positions;

  BoardPainter(this.positions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    if (positions.length >= 22) {
      // ejemplo: serpiente de 17 a 7
      canvas.drawLine(positions[100 - 17], positions[100 - 7], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


Center(
            child: ElevatedButton(
              onPressed: () {
                boardController.moverFicha_action();
                
              },
              child: const Text('¡Presióname!'),
            ),
          ),

		  
// Crear bubble encima de la ficha
    bubble = TextComponent(
      text: '¡Hola!',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          backgroundColor: Colors.white
        ),
      ),
    )
    ..position = ficha.position + Vector2(0, -20)
    ..anchor = Anchor.bottomLeft;

    add(bubble);
	
Positioned(
            top: boardController.mapPosCeldas[1]!.dy-screenAlt*0.0749,
            left:boardController.mapPosCeldas[1]!.dx,
            child: 
              Bubble(
                margin: BubbleEdges.all(10),
                nip: BubbleNip.leftBottom,
                color: Colors.white,
                child: Text(
                  '¡Hola, soy un mensaje estilo cómic!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ),    