part of 'home_body.dart';

class UserSurveyList extends StatelessWidget {
  final void Function() fnOnDetailTap;
  final void Function() fnOnEditTap;
  final void Function() fnOnDeleteTap;

  const UserSurveyList({
    super.key,
    required this.fnOnDetailTap,
    required this.fnOnEditTap,
    required this.fnOnDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16.0),
        Text('Mis encuestas', style: Theme.of(context).textTheme.headlineSmall),
        Text('Administra todas las encuestas que has creado.'),
        ElevatedButton(onPressed: () {}, child: Text('Crear encuesta')),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            itemBuilder: (BuildContext context, int index) {
              return CustomCard(
                isManagementView: true,
                fnOnDetailTap: fnOnDetailTap,
                fnOnEditTap: fnOnEditTap,
                fnOnDeleteTap: fnOnDeleteTap,
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
