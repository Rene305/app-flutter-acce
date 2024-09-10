//Importaciones de material y librerías necesarias
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Construccion de un Widget útil para la visualización de arreglos.
Widget showList(List<String> list, context) {
  return Wrap(
      runSpacing: 10.0,
      children: list.map((text) {
        return Card(
            margin: const EdgeInsets.all(1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ));
      }).toList());
}

//Widget útil para la visualización de las redes sociales, con su ícono y funcionamiento de acuerdo a su link.
Widget showMap(Map<String, dynamic> socialNetwork, context) {
  return Wrap(
    children: [
      if (socialNetwork['facebook'] != "" && socialNetwork['facebook'] != null)
        Column(
          children: [
            Text(
              "Facebook",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.facebook),
              onPressed: () {
                _launchURL(socialNetwork["facebook"]);
              },
            ),
          ],
        ),
      if (socialNetwork['twitter'] != "" && socialNetwork['twitter'] != null)
        Column(
          children: [
            Text("Twitter", style: Theme.of(context).textTheme.labelSmall),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.twitter),
              onPressed: () {
                _launchURL(
                    "https://www.twitter.com/${socialNetwork['twitter']}");
              },
            ),
          ],
        ),
      if (socialNetwork['instagram'] != "" &&
          socialNetwork['instagram'] != null)
        Column(
          children: [
            Text("Instagram", style: Theme.of(context).textTheme.labelSmall),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.instagram),
              onPressed: () {
                _launchURL(
                    "https://www.instagram.com/${socialNetwork['instagram']}");
              },
            ),
          ],
        ),
      if (socialNetwork['mail'] != "" && socialNetwork['mail'] != null)
        Column(
          children: [
            Text("Mail", style: Theme.of(context).textTheme.labelSmall),
            IconButton(
              icon: const Icon(Icons.mail),
              onPressed: () {
                //url = Uri.parse(socialNetwork["mail"]);
                //launchUrl(url);
              },
            ),
          ],
        ),
    ],
  );
}

//Función necesaria para la ejecución de links cargados en la parte del Widget showMap
Future<void> _launchURL(url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalNonBrowserApplication,
  )) {
    throw "No se puede ejecutar";
  }
}
