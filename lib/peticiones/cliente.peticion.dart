// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:crud_en_flutter/modelos/usuario.model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//Inicio del GET de Usuaros-SisGSI
Future<List<Usuario>> listUsuario() async {
  final response =
      await http.get(Uri.parse('http://localhost:3016/sisgsi/usuarios'));
  print(response.body);
  return compute(goToList, response.body);
}

//Luego del GET, se llena la lista con los datos recuperados.
List<Usuario> goToList(String responseBody) {
  final pasar = json.decode(responseBody);
  return pasar['datos'].map<Usuario>((json) => Usuario.fromJson(json)).toList();
}

//Permite Agregar un registro
Future<Usuario> addUsuario(Usuario usuario) async {
  var url = Uri.parse('http://localhost:3016/sisgsi/usuario');
  var body = json.encode(mapUsuario(usuario, false));

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);
  if (response.statusCode == 201) {
    return Usuario.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode.toString());
    throw Exception(
        'Error al tratar de INSERTAR registro de la tabla de Usuarios. El Error es ${response.statusCode}');
  }
}

mapUsuario(Usuario usuario, bool mapId1) {
  Map data1;
  if (mapId1) {
    data1 = {
      'uclCodigo': '${usuario.uclCodigo}',
      'uclCodcel': '${usuario.uclCodcel}',
      'uclCoduni': '${usuario.uclCoduni}',
      'uclUsuario': '${usuario.uclUsuario}',
      'uclEstado': '${usuario.uclEstado}',
    };
  } else {
    data1 = {
      'uclCodigo': '${usuario.uclCodigo}',
      'uclCodcel': '${usuario.uclCodcel}',
      'uclCoduni': '${usuario.uclCoduni}',
      'uclUsuario': '${usuario.uclUsuario}',
      'uclEstado': '${usuario.uclEstado}',
    };
  }
  return data1;
}

//Permite modificar los datos
Future<Usuario> modifyUsusario(Usuario usuario, String codigo) async {
  var url = Uri.parse('http://localhost:3016/sisgsi/usuario/$codigo');

  var body = json.encode(mapUsuario(usuario, true));
  print(body);

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);

  print(body);
  if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body)['usuario']);
  } else {
    print(response.statusCode);
    throw Exception(
        'Error al tratar de Modificar registro de la tabla de Usuarios');
  }
}

//Permite borrar los datos.
Future<Usuario> deleteUsuario(String Codcel, String Coduni) async {
  final http.Response response = await http.delete(
    Uri.parse(
        'http://localhost:3016/sisgsi/usuario/?uclCodcel=$Codcel&uclCoduni=$Coduni'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(
      'http://localhost:3016/sisgsi/usuario/?uclCodcel=$Codcel&uclCoduni=$Coduni');
  if (response.statusCode == 200) {
    return Usuario.fromJson(jsonDecode(response.body)['usuario']);
  } else {
    print(response.statusCode);
    throw Exception(
        'Error al tratar de eliminar registro de la tabla de Usuarios');
  }
}
