import 'package:crud_en_flutter/pantallas/message_response.dart';
import 'package:crud_en_flutter/pantallas/modify_contact.dart';
import 'package:crud_en_flutter/pantallas/register_contact.dart';
import 'package:crud_en_flutter/peticiones/cliente.peticion.dart';
import 'package:flutter/material.dart';
import '../modelos/usuario.model.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: getUsuarios(context, listUsuario()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterContact()))
              .then((newUsuario) {
            setState(() {
              messageResponse(
                  context, newUsuario.name + " a sido guardado...!");
            });
            //setState(() {});
            Navigator.pop(context, Usuario);
          });
        },
        tooltip: "Agregar Contacto",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getUsuarios(
      BuildContext context, Future<List<Usuario>> futureUsuario) {
    return FutureBuilder(
      future: futureUsuario,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el cargando...
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            return snapshot.data != null
                ? usuariosList(snapshot.data)
                : Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text('Sin Datos'),
                    ),
                  );
          default:
            return Text('Recarga la pantalla....!');
        }
      },
    );
  }

  Widget usuariosList(List<Usuario> usuario) {
    return ListView.builder(
      itemCount: usuario.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ModifyUsuario(usuario[index])))
                .then((newUsuario) {
              setState(() {
                messageResponse(
                    context, newUsuario.name + " a sido modificado...!");
              });
              Navigator.pop(context);
            });
          },
          onLongPress: () {
            //Si se presiona el registro por largo tiempo, pregunta si DESEA ELIMINAR EL REGISTRO
            removeClient(context, usuario[index]);
          },
          title: Text('Usuario - ' +
              usuario[index].uclCodigo.toString() +
              " - " +
              usuario[index].uclUsuario),
          subtitle: Text('Unidad: ' + usuario[index].uclCoduni.toString()),
          leading: CircleAvatar(
            child: Text(usuario[index].uclUsuario.substring(0, 1)),
          ),
          trailing: Icon(
            Icons.edit_note,
            color: Colors.red,
          ),
        );
      },
    );
  }

  removeClient(BuildContext context, Usuario usuario) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar Cliente"),
              content: Text("Esta seguro de eliminar a " +
                  usuario.uclCodcel +
                  '-' +
                  usuario.uclCoduni.toString() +
                  "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      deleteUsuario(
                              usuario.uclCodcel, usuario.uclCoduni.toString())
                          .then((usuario) {
                        if (usuario.uclUsuario != '') {
                          setState(() {});
                        }
                      });
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }

/*
  Widget getClients(BuildContext context, Future<List<Client>> futureClient) {
    return FutureBuilder(
      future: futureClient,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el cargando...
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasError)
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            print(snapshot.data);
            return snapshot.data != null
                ? clientList(snapshot.data)
                : Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text('Sin Datos'),
                    ),
                  );
          default:
            return Text('Recarga la pantalla....!');
        }
      },
    );
  }

  Widget clientList(List<Client> clients) {
    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ModifyContact(clients[index])))
                .then((newContact) {
              setState(() {
                messageResponse(
                    context, newContact.name + " a sido modificado...!");
              });
            });
          },
          onLongPress: () {
            removeClient(context, clients[index]);
          },
          title: Text(clients[index].name + " " + clients[index].surname),
          subtitle: Text(clients[index].phone),
          leading: CircleAvatar(
            child: Text(clients[index].name.substring(0, 1)),
          ),
          trailing: Icon(
            Icons.call,
            color: Colors.red,
          ),
        );
      },
    );
  }

  removeClient(BuildContext context, Client client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar Cliente"),
              content: Text("Esta seguro de eliminar a " + client.name + "?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      deleteClient(client.id).then((cliente) {
                        if (cliente.id != '') {
                          setState(() {});
                        }
                      });
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ));
  }
}*/
}
