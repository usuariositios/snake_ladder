import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake_ladder1/controllers/jugador_controller.dart';
import 'package:snake_ladder1/model/LadderPositions.dart';

import 'package:snake_ladder1/model/Positions.dart';
import 'package:snake_ladder1/model/Snake.dart';
import 'package:snake_ladder1/model/SnakePositions.dart';

import 'dart:ui' as ui;

import 'package:snake_ladder1/model/players.dart';
import 'package:snake_ladder1/model/preguntas_juego.dart';
import 'package:snake_ladder1/service/service.dart';
import 'package:snake_ladder1/widgets/animated_player.dart';


import 'package:snake_ladder1/widgets/casilla.dart';



class BoardController extends GetxController    { //with GetTickerProviderStateMixin
  final int boardSize = 100;

  // GlobalKeys para cada casilla
  final List<GlobalKey> tileKeys = List.generate(100, (_) => GlobalKey());

  // Posiciones en pantalla de cada casilla
  RxList<Offset> tilePositions = <Offset>[].obs;
  RxList<Positions> positionsList = <Positions>[].obs;//para variar en la vista (posiciones en el tablero)
  late ui.Image snakeImage;
  RxBool isImageLoaded = false.obs;
  RxInt numberDice = 1.obs;  //valor del dice de la cajita
  RxInt numberDice1 = 1.obs;  //valor del dice de la cajita
  RxInt numberDice2 = 1.obs;  //valor del dice de la cajita
  Rx<Players> player1 = Players().obs;//falta
  Rx<Players> player2 = Players().obs;//falta
  Rx<Players> playerx = Players().obs;//falta
  RxInt turnoPlayerx = 0.obs;//tiene que ir rotando el turno

  RxList<Players> playersList = <Players>[].obs;//List.generate(8, (_)=>Players()).obs;//relacionar jugadoresController.jugadores con la lista





  RxList<SnakePositions> snakePositionsList = <SnakePositions>[].obs;
  RxList<LadderPositions> ladderPositionsList = <LadderPositions>[].obs;
  // Offset observable
  //Rx<Offset> posicion = Offset(100, 300).obs;//posicion antes y despues de la animacion

  /*late AnimationController animController;
  late Animation<Offset> animOffset;
  late Animation<double> animProgress;*/

  Offset inicio = Offset(100, 300);
  Offset fin = Offset(250, 100);
  late List<Offset> ruta; // Lista de posiciones a las que brincar
  int indiceActual = 0;
  //late List<int> indiceList = List.generate(100, (_)=>0);//numeros de las casillas con colores
  late List<Casilla> indiceList = List.generate(100, (_)=>Casilla(indice:0,color:Colors.white));//numeros de las casillas con colores
  //final apController = Get.find<AnimatePlayerController>();
  final apController = Get.put(AnimatePlayerController());
  final jugadorController = Get.put(JugadorController());


  List<PreguntasJuego> preguntasJuegoList=[];
  int indicePreguntaJuego = 0;
  RxBool disableDice = false.obs;
  RxBool hideMessage = false.obs;
  



  



  


  List<Snake> snakeList = [];


  @override
  void onInit() {
    super.onInit();
    iniciaIndices();
    
    // Inicialización en onInit()
    cargarArchivosJson();//de json
    print('longitud lista ${jugadorController.jugadores.length}' );
    playersList = List.generate(jugadorController.jugadores.length, (_)=>Players()).obs;//relacionar jugadoresController.jugadores con la lista
    for(int i=0;i<jugadorController.jugadores.length;i++ ){
      playersList[i].colorPlayers = jugadorController.jugadores[i].nombreColorJugador;//asignacion de colores
      playersList[i].nombre = jugadorController.jugadores[i].nombre;
      jugadorController.jugadores[i].numCaja = 1; //reseteamos la caja
    }

  }

  void iniciaIndices(){//indice de tablero en forma de u de 10 en 10 para intercambiar si suma o resta
    int count = 0;
    int sw = 0;
    int indice = 100;
    Casilla c = Casilla(indice: 0,color:Color(0xFFF0B1924));//no declarar final por que con el constructor se convierte en valor final del objeto
    List<Color> colorList = [Color(0xFF17ACE4),Color(0xFFFAA531),Color(0xFFE72693),];
    int indiceColor = 0;

    for(int i = 0;i<100;i++){
      c =   indiceList[i];
      c.color = Color(0xFFF0B1924);
      if(count<=10 && sw==0){
        indice = 100-i;
        count++;
        c.indice= indice;
      }      
      if(count<=10 && sw==1){
        indice = indice+1;
        count++;
        c.indice = indice;
      }
      //print('indice: $indice');
      //definicion del color
      //agarrar uno de la lista
      if(indice%2!=0) {//fila par impar "sw"
        
        c.color = colorList[indiceColor];            

        indiceColor++;
        if(indiceColor>2){//rotar los colores
          indiceColor=0;
        }
      }
      
      if(count==10){
        if(sw==0){
          sw=1;          
          indice = indice-11;          
          indiceColor=1;//aqui se resetea el color          
        }else if(sw==1){
          sw=0;
          indiceColor=0;//aqui se resetea el color          
        }
        count = 0;
      }
      
        
      }

  }

  void iniciarSalto(int numUbicFin) async{ //se registra la lista con las nuevas posiciones a saltar
  
    
    //calcular aqui la lista de nuevaRuta
    //verificar a quien le toca
    /*if(turnoPlayerx.value==1){
      playerx = player1;
      numberDice = numberDice1;
      
    }else if(turnoPlayerx.value==2){
      playerx = player2;
      numberDice = numberDice2;
      
    }*/
    for(var i = 0; i< jugadorController.jugadores.length;i++){//tomar en cuenta el turno desde 0 (depende de los jugadores)
      if(i==turnoPlayerx.value){
        //print('es turno de $i');
        playerx.value = playersList[i];//coloca la ubicacion
        numberDice.value = jugadorController.jugadores[i].numCaja;
        break;
      }
    }
    
    

    
    await Future.delayed(Duration(seconds: 1));

    int start = numberDice.value;//el numero de dice debe ser independiente(es el numero de cajita)
    
    
    ruta = [];
    ruta.add(playerx.value.posicion.value);//es que es rx (colocamos la posicion inicial)
    for(var i= start;i<start+numUbicFin;i++ ){
        numberDice.value += 1;
        ruta.add(getTilePosition1(numberDice.value));
        
        //print('posicion adicionada ${numberDice.value} ruta.length ${ruta.length}' );
    }

    for(SnakePositions sp in snakePositionsList){//si coincide con la posicion final cambiamos su posicion al inicial
          
          if(sp.ubicIni==numberDice.value){
            numberDice.value = sp.ubicFin??0;
            ruta.add(getTilePosition1(numberDice.value));
            
            break;
          }
    }

    for(LadderPositions lp in ladderPositionsList){//si coincide con la posicion inicial cambiamos su posicion al final y bebe
          if(lp.ubicFin==numberDice.value){

            
            ruta.addAll(getTweenOffsets(getTilePosition1(numberDice.value), getTilePosition1(lp.ubicIni??0), 4));//se generan 4 escalones de inicio a la posicion final de ladder genera hasta el penultimo
            numberDice.value = lp.ubicIni??0;
            ruta.add(getTilePosition1(numberDice.value));
            
            break;
          }
    }

    

    /*if(turnoPlayerx.value==1){      
      numberDice1 = numberDice;
      turnoPlayerx.value=2;
      
    }else if(turnoPlayerx.value==2){      
      numberDice2 = numberDice;
      turnoPlayerx.value=1; 
    }*/

    

  

    //ruta = nuevaRuta;
      indiceActual = 0;//resetea la posicion actual
    //if (ruta.length >= 2) {// al menos 2 posiciones
      playerx.value.posicion.value = ruta[0];//comienza la posicion ya que en el array esta la posicion inicial para saltar
      
      apController.ruta = ruta;
      apController.indiceActual = indiceActual;
      apController.posicion = playerx.value.posicion;//se actualiza esta posicion con el otro controlador


      apController.swMostrarMensaje=1;//para mostrar la pregunta
      indicePreguntaJuego++;
      apController.mensaje="${playersList[turnoPlayerx.value].nombre}  \n \"${preguntasJuegoList[indicePreguntaJuego].tituloPregunta}\" \n ${preguntasJuegoList[indicePreguntaJuego].pregunta}";
      
      
      disableDice.value = true;//disable dice


      //rutina para al siguiente turno
    for(var i = 0; i< jugadorController.jugadores.length;i++){//tomar en cuenta el turno desde 0
      if(i==turnoPlayerx.value){        
        jugadorController.jugadores[i].numCaja = numberDice.value;
        turnoPlayerx.value++;//para el siguiente jugador
        if(turnoPlayerx.value>jugadorController.jugadores.length-1){
          turnoPlayerx.value=0;//reset de turno
        }
        break;
      }
    }

    

      apController.mover();
      

      


      
      //animController.reset();//detiene la animacion
      //animController.forward();//empieza la animacion
    //}
  }

  void cerrarMensaje( var msg ){
    apController.mensajeList.remove(msg);
    disableDice.value=false;  
    Get.snackbar(
          '',
          '' ,
          icon: Image.asset(
            'assets/images/player_${playersList[turnoPlayerx.value].colorPlayers}.png',
            width: 30,
            height: 30,
          ),
          snackPosition: SnackPosition.BOTTOM,
          messageText: Center(
          child: Text('Turno de ${playersList[turnoPlayerx.value].nombre}',),
          ),
          
          

    );

  }

 
    
    


  List<Offset> getTweenOffsets(Offset start, Offset end, int n) {//obtiene n offsets entre dos offsets
    final tween = Tween<Offset>(begin: start, end: end);
    final List<Offset> points = [];
    
    for (int i = 1; i <= n; i++) {
      final double t = i / (n + 1); // Valor entre 0 y 1
      points.add(tween.lerp(t));
    }
    
    return points;
  }

   Future<void> cargarArchivosJson() async {
    snakePositionsList.assignAll(await Service.cargarSnakePosiciones('assets/data/snake_positions.json'));
    ladderPositionsList.assignAll(await Service.cargarLadderPosiciones('assets/data/ladder_positions.json'));
    preguntasJuegoList = await Service.cargarPreguntasLocal('assets/data/preguntas_es.json');
    preguntasJuegoList.shuffle();
    



   }


  
  



  
  

  

  // Llama esto después del primer render
  void calculateTilePositions() {// las posiciones offset en el tablero
    List<Offset> positions = [];
    String? numero;
    double? appBarHeight=0.0;

    

    for (int i = 0; i < tileKeys.length; i++) {
      final context = tileKeys[i].currentContext;
      

      
      
      if (context != null) {
        appBarHeight = Scaffold.of(context).appBarMaxHeight;//la altura del appbar
        

        final box = context.findRenderObject() as RenderBox;
        final center = box.localToGlobal(box.size.center(Offset.zero));
        numero = (((tileKeys[i].currentWidget as Container?)!.child as Center).child as Text).data;
        positions.add(center);        
        //para la lista
        
        Positions p = Positions(numero: numero!,
        position:  center,
        px: center.dx,//se relaciona el numero con la posicion
        py: (center.dy-appBarHeight!));        
        positionsList.add(p);


      }
    }

    tilePositions.value = positions;
    //posicion = Offset(300, 500).obs;
    
  }
  void actualizaPosicion(int numUbic) async{    
    //numberDice.value += numUbic;
    int start = numberDice.value;
    for(var i= start;i<start+numUbic;i++ ){//la ultima posicion es la que cuenta
        await Future.delayed(Duration(milliseconds: 700));
        numberDice.value += 1;        
    }
    //mover(getTilePosition1(numberDice.value),Offset(250, 100));

    /*for(var i= start;i<start+numUbic;i++ ){//la ultima posicion es la que cuenta
        
        
        await Future.delayed(Duration(seconds: 3));
        //numberDice.value += 1;
    }*/





    for(SnakePositions sp in snakePositionsList){//si coincide con la posicion final cambiamos su posicion al inicial
          if(sp.ubicFin==numberDice.value){
            await Future.delayed(Duration(seconds: 1));
            numberDice.value = sp.ubicIni??0;
            break;
          }
    }

    for(LadderPositions lp in ladderPositionsList){//si coincide con la posicion inicial cambiamos su posicion al final
          if(lp.ubicIni==numberDice.value){
            await Future.delayed(Duration(seconds: 1));
            numberDice.value = lp.ubicFin??0;
            break;
          }
    }

    

  }

  Offset getTilePosition(int tileNumber) {

    //print('$tileNumber ${tilePositions[tileNumber].dx}');

    int index = 100 - tileNumber; // 100 arriba, 1 abajo
    if (index < 0 || index >= tilePositions.length) return Offset.zero;
    return tilePositions[index];
  }
  Offset getTilePosition1(int tileNumber) {
    Offset o = Offset(0, 0);

    //print('$tileNumber ${tilePositions[tileNumber].dx}');
    for(var i=0;i< positionsList.length;i++ ){
      //print('comparacion ....${positionsList[i].numero} -  $tileNumber');
      if(int.parse(positionsList[i].numero) ==tileNumber ){
        //o = positionsList[i].position;
        o = Offset(positionsList[i].px, positionsList[i].py);//con la altura del appbar

        break;
      }
    }    
    return o;
  }


  void mover(Offset desde, Offset hasta) {
    /*inicio = desde;
    fin = hasta;

    animController.reset();
    animController.forward();*/
  }

  



  
  @override
  void onClose() {
    //animController.dispose();
    super.onClose();
  }
}