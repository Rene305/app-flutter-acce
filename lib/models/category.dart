class Category {
  int id;
  String name;
  String icon;
  String route;

  Category(this.id, this.name, this.icon, this.route);
}

final menu = [
  Category(1, "Listado de Fundaciones",
      "assets/images/icons_buttons/ic_lista.png", "/listado"),
  Category(2, "Detección Temprana",
      "assets/images/icons_buttons/ic_listado.png", "/preguntas"),
  Category(3, "Denuncias", "assets/images/icons_buttons/ic_denuncia.png",
      "/denuncia"),
];
