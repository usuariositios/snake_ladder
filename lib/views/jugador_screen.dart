import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snake_ladder1/controllers/jugador_controller.dart';
import 'package:snake_ladder1/model/jugador.dart';
import 'package:snake_ladder1/widgets/selector_color_simple.dart';



class JugadorScreen extends StatelessWidget {
  JugadorScreen({Key? key}) : super(key: key);

  final JugadorController controller = Get.put(JugadorController());
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  

  void _showAddDialog(BuildContext context) {
    nombreController.clear();
    edadController.clear();
    controller.nombreColorJugador.value = "";
    showDialog(
      context: context,
      builder: (_) { 
        final width = MediaQuery.of(context).size.width * 0.9; // 80%
        return AlertDialog(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
              Text('Agregar Jugador'),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close),
                  ),
                ],
        ),
        content: Obx(() =>
        SizedBox(
        width: width,
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(hintText: 'Nombre')),
            SizedBox( height: 20,),
            Row(
              children: [
                const Text('Color'),
                ButtonColores(context),
              ],
            ),
            
          ],
        )

        )
        ),
        actions: [
          SizedBox(
            width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.transparent,
                    side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, // Borde adaptado al tema
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                ),
                ),


                  onPressed: () {
                    final nombre = nombreController.text.trim();
                    

                    if (nombre.isNotEmpty) {
                      //print('nombreColor seleccionado: $nombreColor');
                      controller.agregarJugador(Jugador(nombre: nombre, edad: 0,numCaja: 1,nombreColorJugador: controller.nombreColorJugador.value,colorJugador: controller.colorJugador.value));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
          )
        ],
      );
      }
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final jugador = controller.jugadores[index];
    nombreController.text = jugador.nombre;
    edadController.text = jugador.edad.toString();
    controller.nombreColorJugador.value = controller.jugadores[index].nombreColorJugador;
    controller.colorJugador.value = controller.jugadores[index].colorJugador;


    showDialog(
      context: context,
      builder: (_) { 
        final width = MediaQuery.of(context).size.width * 0.9; // 80%
         return AlertDialog(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Editar Jugador'),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close),
            ),
          ],
      ),
        content:

        Obx(() =>
        SizedBox(
        width: width,
        child:
        
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            SizedBox( height: 20,),
            Row(
              children: [
                const Text('Color'),
                ButtonColores(context),
              ],
            ),
          ],
        ),
        ),
        ),

        actions: [

          SizedBox(
            width: double.infinity,
              child:
          TextButton(
            style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.transparent,
                    side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, // Borde adaptado al tema
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                ),
                ),
            onPressed: () {
              final nombre = nombreController.text.trim();
              

              if (nombre.isNotEmpty) {
                controller.editarJugador(index, Jugador(nombre: nombre, edad: 0,numCaja: 1,nombreColorJugador: controller.nombreColorJugador.value,colorJugador: controller.colorJugador.value));
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
          )

        ],
      );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 80%
    
    return Scaffold(
      appBar: AppBar(title: Text('')),
      
      body:
       Center(
        child: Container(
          width: size.width * 0.9,   // 80% del ancho de pantalla
          height: size.height * 0.4, // 40% del alto de pantalla
          //padding: EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            
          ),
          child: Obx(() => 
          Column(
            children: [
              Expanded(
                child:
          ListView.builder(
            itemCount: controller.jugadores.length,
            itemBuilder: (context, index) {
              final jugador = controller.jugadores[index];
              return ListTile(
                title: Text(jugador.nombre),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: jugador.colorJugador,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    IconButton(onPressed: () => _showEditDialog(context, index), icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () => controller.eliminarJugador(index), icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            },
          ),
              ),

          SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
              child:
          
            TextButton(
                style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Colors.transparent,
                    side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, // Borde adaptado al tema
                    ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                ),
                ),
                  onPressed: () {
                    controller.colorJugador.value = Colors.white;
                    _showAddDialog(context);                    
                  },
                  child: const Text('+ Agregar jugador'),
                ),
              )



          ]
          
          ),


          )
        ),
      
       
    )
    );
  }
  Widget ButtonColores(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
            shape: CircleBorder(),            
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Elige un color'),
                  content: SelectorColorSimple(
                    colores: [
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.yellow,
                      Colors.orange,
                      Colors.purple,
                    ],
                    onSeleccionar: (nombreColor,color) {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      //print('Color elegido: ${controller.nombreColorJugador.value} ');
                      
                        controller.nombreColorJugador.value = nombreColor;
                        controller.colorJugador.value = color;
                      

                      // Aquí puedes actualizar un controlador, setState, etc.
                    },
                  ),
                );
              },
            );
          },
          child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: controller.colorJugador.value,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                ),
  );
  }
}