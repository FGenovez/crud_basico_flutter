class Usuario {
  int uclCodigo;
  String uclCodcel;
  int uclCoduni;
  String uclUsuario;
  String uclEstado;

  Usuario(
      {this.uclCodigo,
      this.uclCodcel,
      this.uclCoduni,
      this.uclUsuario,
      this.uclEstado});
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        uclCodigo: json['uclCodigo'],
        uclCodcel: json['uclCodcel'],
        uclCoduni: json['uclCoduni'],
        uclUsuario: json['uclUsuario'],
        uclEstado: json['uclEstado']);
  }
}
