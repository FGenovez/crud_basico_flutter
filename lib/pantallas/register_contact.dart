import 'package:crud_en_flutter/modelos/usuario.model.dart';
import 'package:crud_en_flutter/pantallas/text_box.dart';
import 'package:crud_en_flutter/peticiones/cliente.peticion.dart';
import 'package:flutter/material.dart';

class RegisterContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterContact();
}

class _RegisterContact extends State<RegisterContact> {
  TextEditingController controlleruclcodigo;
  TextEditingController controlleruclcodcel;
  TextEditingController controlleruclcoduni;
  TextEditingController controlleruclusuario;
  TextEditingController controlleruclestado;

  @override
  void initState() {
    //controlleruclcodigo = new TextEditingController();
    controlleruclcodcel = new TextEditingController();
    controlleruclcoduni = new TextEditingController();
    controlleruclusuario = new TextEditingController();
    controlleruclestado = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrar Usuarios"),
        ),
        body: ListView(
          children: [
            TextBox(controlleruclcodcel, "CodCEL"),
            TextBox(controlleruclcoduni, "Unidad"),
            TextBox(controlleruclusuario, "Usuario"),
            TextBox(controlleruclestado, "Estado"),
            ElevatedButton(
                onPressed: () {
                  String codcel = controlleruclcodcel.text;
                  String coduni = controlleruclcoduni.text;
                  String usuario = controlleruclusuario.text;
                  String estado = controlleruclestado.text;
                  if (codcel.isNotEmpty &&
                      usuario.isNotEmpty &&
                      estado.isNotEmpty) {
                    Usuario c = new Usuario(
                        uclCodigo: int.parse('0'),
                        uclCodcel: codcel,
                        uclCoduni: int.parse(coduni),
                        uclUsuario: usuario,
                        uclEstado: estado);
                    addUsuario(c).then((usuario) {
                      if (usuario.uclCodcel != '') {
                        print('Usuario registrado...!');
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                child: Text("Guardar Usuario")),
          ],
        ));
  }
}
