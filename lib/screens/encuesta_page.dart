import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> options;

  Question(this.question, this.options);
}

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<String> selectedAnswers = List.filled(questions.length, '');

  double calculateScore() {
    double score = 0.0;

    for (int i = 0; i < questions.length; i++) {
      int selectedOption = questions[i].options.indexOf(selectedAnswers[i]) + 1;

      if (questions[i].options.length == 4) {
        if (selectedOption == 1) {
          score += 1.0;
        } else if (selectedOption == 2) {
          score += 0.75;
        } else if (selectedOption == 3) {
          score += 0.50;
        } else if (selectedOption == 4) {
          score += 0.25;
        }
      } else if (questions[i].options.length == 3) {
        if (selectedOption == 1) {
          score += 1.0;
        } else if (selectedOption == 2) {
          score += 0.66;
        } else if (selectedOption == 3) {
          score += 0.33;
        }
      } else if (questions[i].options.length == 2) {
        if (selectedOption == 1) {
          score += 1.0;
        } else if (selectedOption == 2) {
          score += 0.50;
        }
      }
    }

    return score;
  }

  void navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(score: calculateScore()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionario'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index].question,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: questions[index].options.map((option) {
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          bool allQuestionsAnswered =
              selectedAnswers.every((answer) => answer.isNotEmpty);
          if (allQuestionsAnswered) {
            navigateToResultScreen();
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('¡Atención!'),
                content: const Text('Por favor, responde todas las preguntas.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            );
          }
        },
        child: const Text('Calcular Resultado'),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double score;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: Center(
        child: Text(
          'Tu probabilidad de tener cáncer es ${(score / 22 * 100).toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

List<Question> questions = [
  Question(
    '¿Alguno de Tus Familiares Ha Sufrido Cáncer?',
    [
      'Sí, familiares de primer grado (padre, madre, hermanos)',
      'Sí, familiares de segundo grado (abuelos, tíos)',
      'No'
    ],
  ),
  Question(
    '¿Visitas Regulares Al Ginecólogo Y/O Urólogo?',
    [
      'No, solo cuando me deriva el médico de familia',
      'Sí, lo hago una vez al año',
      'Sí, cada cierto tiempo, pero no regularmente'
    ],
  ),
  Question(
    '¿Qué Frecuencia Consumes Carne Roja?',
    [
      'Casi cada día',
      '2-3 veces por semana',
      '1 vez a la semana',
      'Menos de 1 vez a la semana'
    ],
  ),
  Question(
    '¿Con Qué Frecuencia Consumes Carne Procesada (Embutidos, Frankfurts, Etc.)?',
    [
      'Casi cada día',
      '2-3 veces por semana',
      '1 vez a la semana',
      'Menos de 1 vez a la semana'
    ],
  ),
  Question(
    '¿Tomas Muchos Fritos, Rebozados Cocinados A Altas Temperaturas?',
    [
      'Casi ada día',
      '2-3 veces por semana',
      '1 vez a la semana',
      'Menos de 1 vez a la semana'
    ],
  ),
  Question(
    '¿Tomas Las 5 Raciones Diarias De Fruta Y Verdura Recomendadas?',
    [
      'Consigo hacerlo 1 vez a la semana',
      'Consigo hacerlo de 1 a 3 vez a la semana',
      'Consigo hacerlo entre 4 y 5 veces por semana',
      'Lo hago prácticamente cada día'
    ],
  ),
  Question(
    '¿Sueles Comer Comida Precocinada O Fast Food?',
    [
      'Sí, casi siempre, no cocino mucho',
      'Solo 2 o 3 veces por semana',
      'No, nunca más de 1 vez por semana',
      'Muy raramente'
    ],
  ),
  Question(
    '¿Cuántas Veces Tomas Bollería O Pastelería Industrial?',
    [
      'Casi cada día'
          'Unas 3 o 4 veces por semana',
      'Solo durante el fin de semana',
      'Muy raramente',
    ],
  ),
  Question(
    '¿Estás En Tu Peso Ideal?',
    [
      'Tengo un sobrepeso importante',
      'Me sobran 6 o 7 kilos',
      'Me sobran 2 o 4 kilos',
      'Sí',
    ],
  ),
  Question(
    '¿Haces Ejercicio Con Frecuencia?',
    [
      'No',
      'No voy al gimnasio, pero salgo a andar el fin de semana',
      'Suelo andar unos 30 minutos al día a buen paso',
      'Voy al gimnasio 2 o 3 veces por semana y ando mucho',
    ],
  ),
  Question(
    '¿Has Sido Fumador/A?',
    [
      'Sí, sigo fumando',
      'Sí, pero hace menos de 10 años que lo dejé',
      'Sí, pero hace más de 10 años que lo dejé',
      'No, nunca he fumado',
    ],
  ),
  Question(
    '¿Qué Frecuencia Bebes Alcohol?',
    [
      'Cada día, 2 o 3 copas o cervezas',
      '1 o 2 copas o cervezas cada día',
      'Solo el fin de semana, pero paso de 6 copas o cervezas',
      'No, bebo ocasionalmente',
    ],
  ),
  Question(
    '¿Te Quemaste Muchas Veces Tomando El Sol Durante Tu Infancia?',
    [
      'Sí, más de una vez',
      'Alguna vez',
      'No, nunca me he quemado',
    ],
  ),
  Question(
    '¿Sueles Usar Cabinas De Rayos Uva?',
    [
      'Sí',
      'No',
    ],
  ),
  Question(
    '¿Te Pones Protección Solar Para Tomar El Sol?',
    [
      'Nunca',
      'Raras veces',
      'Casi siempre',
      'Siempre',
    ],
  ),
  Question(
    'Cuando No Vas A Tomar El Sol, ¿Usas Protección Solar?',
    [
      'No, no me hace falta',
      'Sí, uso crema de cara con protección',
      'Sí, no solo en la cara',
    ],
  ),
  Question(
    '¿Tienes Más De 11 Lunares En El Brazo Derecho?',
    [
      'Sí',
      'No',
    ],
  ),
  Question(
    '¿Has Sido Madre?',
    ['Sí', 'No', 'Soy un hombre'],
  ),
  Question(
    '¿Has Optado Por La Lactancia Materna?',
    [
      'Sí',
      'No',
      'No he tenido hijos',
      'Soy hombre',
    ],
  ),
  Question(
    '¿Tienes Un Trabajo De Riesgo?',
    [
      'Sí, trabajo en una fundición de acero, soy radiólogo, pintor...',
      'Sí, soy peluquero, trabajo de noche, en una tintorería, en una refinería...',
      'No, tengo un trabajo de poco riesgo',
      'No lo sé',
    ],
  ),
  Question(
    '¿Dónde Vives?',
    [
      'En una gran ciudad',
      'En una ciudad mediana o un pueblo grande',
      'En un pueblo pequeño o en el campo',
    ],
  ),
  Question(
    '¿Ventilas Tu Casa Cada Día?',
    ['No', 'Sí'],
  ),
];

void main() {
  runApp(MaterialApp(
    title: 'Flutter Preguntas',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const QuestionsScreen(),
  ));
}
