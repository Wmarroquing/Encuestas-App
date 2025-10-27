part of 'home_body.dart';

class CustomCard extends StatelessWidget {
  final bool isManagementView;
  final SurveyModel currentSurvey;
  final void Function(SurveyModel)? fnOnDetailTap;
  final void Function(SurveyModel)? fnOnEditTap;
  final void Function(String)? fnOnDeleteTap;
  final void Function(String)? fnOnCopyCode;

  const CustomCard({
    super.key,
    required this.currentSurvey,
    required this.isManagementView,
    this.fnOnDetailTap,
    this.fnOnEditTap,
    this.fnOnDeleteTap,
    this.fnOnCopyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              currentSurvey.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CustomColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              currentSurvey.description,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Visibility(
            visible: isManagementView,
            child: ListTile(
              title: Text(
                'Código: ${currentSurvey.code}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: CustomColors.textSecondary,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  if (fnOnCopyCode != null) fnOnCopyCode!(currentSurvey.code);
                },
                icon: Icon(Icons.copy),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  if (fnOnDetailTap != null) fnOnDetailTap!(currentSurvey);
                },
                icon: Icon(Icons.visibility),
                label: Text('Ver'),
              ),
              TextButton.icon(
                onPressed: () {
                  if (fnOnEditTap != null) fnOnEditTap!(currentSurvey);
                },
                icon: Icon(Icons.edit),
                label: Text('Editar'),
              ),
              TextButton.icon(
                onPressed: () {
                  if (fnOnDeleteTap != null) fnOnDeleteTap!(currentSurvey.id);
                },
                icon: Icon(Icons.delete),
                label: Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
