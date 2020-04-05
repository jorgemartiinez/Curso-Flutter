import 'package:flutter/material.dart';

import 'dart:async';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _scrollController = new ScrollController();

  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

// al crear la página, ponemos un init
  @override
  void initState() {
    super.initState();

    _agregar10Imagenes();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _agregar10Imagenes();
        _fetchData();
      } // largo maximo
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
        .dispose(); // al salir de la página, eliminamos el listener
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading(),
        ],
      ),
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listaNumeros[index];

          return FadeInImage(
            placeholder: AssetImage('assets/original.gif'),
            height: 300,
            fit: BoxFit.cover,
            image: NetworkImage('https://picsum.photos/id/$imagen/500/300'),
          );
        },
      ),
    );
  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration( seconds: 2 );
    new Timer( duration , () {
      _listaNumeros.clear();
      _ultimoItem++;
      _agregar10Imagenes();
    });

    return Future.delayed(duration);
  }

  void _agregar10Imagenes() {
    for (int i = 0; i < 10; i++) {
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {});
  }

  Future _fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    new Timer(duration, _respuestaHTTP);
  }

  void _respuestaHTTP() {
    _isLoading = false;

    _scrollController.animateTo(
        _scrollController.position.pixels +
            100, // mueve el scroll 100px, ya tenemos las siguientes imagenes
        duration: Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn);

    _agregar10Imagenes();
  }

  _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      );
    } else {
      return Container(); // si no esta cargando devuelve un container vacío
    }
  }
}
