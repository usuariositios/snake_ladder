class SnakePositions {
  String? nombreSnake;
  int? ubicIni;
  int? ubicFin;
  String? assets;

  SnakePositions(
      {this.nombreSnake, this.ubicIni, this.ubicFin, this.assets});

  SnakePositions.fromJson(Map<String, dynamic> json) {
    nombreSnake = json['nombreSnake'];
    ubicIni = json['ubicIni'];
    ubicFin = json['ubicFin'];
    assets = json['assets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombreSnake'] = this.nombreSnake;
    data['ubicIni'] = this.ubicIni;
    data['ubicFin'] = this.ubicFin;
    data['assets'] = this.assets;
    return data;
  }
}