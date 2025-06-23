class PreguntasJuego {
  int? codPregunta;
  String? tituloPregunta;
  String? pregunta;
  int? nroTragos;
  int? codCategoria;

  PreguntasJuego(
      {this.codPregunta,
      this.tituloPregunta,
      this.pregunta,
      this.nroTragos,
      this.codCategoria});

  PreguntasJuego.fromJson(Map<String, dynamic> json) {
    codPregunta = json['codPregunta'];
    tituloPregunta = json['tituloPregunta'];
    pregunta = json['pregunta'];
    nroTragos = json['nroTragos'];
    codCategoria = json['codCategoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codPregunta'] = this.codPregunta;
    data['tituloPregunta'] = this.tituloPregunta;
    data['pregunta'] = this.pregunta;
    data['nroTragos'] = this.nroTragos;
    data['codCategoria'] = this.codCategoria;
    return data;
  }
}