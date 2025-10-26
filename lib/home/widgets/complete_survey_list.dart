part of 'home_body.dart';

class CompleteSurveyList extends StatelessWidget {
  final void Function() fnOnDetailTap;

  const CompleteSurveyList({super.key, required this.fnOnDetailTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          spacing: 16.0,
          children: <Widget>[
            Text(
              'Encuestas completadas',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            IconButton.filled(onPressed: () {}, icon: Icon(Icons.add)),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            itemBuilder: (BuildContext context, int index) {
              return Card();
              // return CustomCard(
              //   isManagementView: false,
              //   fnOnDetailTap: fnOnDetailTap,
              // );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
