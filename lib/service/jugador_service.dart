import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';
import 'package:snake_ladder1/model/jugador.dart';

class JugadorService {
  final gets = GetStorage();
  final _key = 'jugadores';

  Future<List<Jugador>> cargarJugadores() async {    
    String? jsonString = gets.read(_key);
    print(' el disco $jsonString');
    if (jsonString == null) {
      // Primera vez: cargar de assets
      jsonString = await rootBundle.loadString('assets/data/jugadores.json');
      await gets.write(_key, jsonString);
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((j) => Jugador.fromJson(j)).toList();
  }

  Future<void> guardarJugadores(List<Jugador> jugadores) async {
    final jsonString = jsonEncode(jugadores.map((j) => j.toJson()).toList());
    await gets.write(_key, jsonString);//guarda toda la lista
  }
}