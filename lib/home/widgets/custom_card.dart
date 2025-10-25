part of 'home_body.dart';

class CustomCard extends StatelessWidget {
  final bool isManagementView;
  final void Function()? fnOnDetailTap;
  final void Function()? fnOnEditTap;
  final void Function()? fnOnDeleteTap;

  const CustomCard({
    super.key,
    required this.isManagementView,
    this.fnOnDetailTap,
    this.fnOnEditTap,
    this.fnOnDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              'Product Feedback Q3',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CustomColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Code: JKL-789',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: CustomColors.textSecondary,
              ),
            ),
            trailing: IconButton(
              color: CustomColors.accent,
              onPressed: fnOnDetailTap,
              icon: Icon(Icons.info),
            ),
          ),
          ListTile(
            title: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              'Completado el 12/12/2024',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Visibility(
            visible: isManagementView,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: fnOnEditTap,
                  icon: Icon(Icons.edit),
                  label: Text('Editar'),
                ),
                TextButton.icon(
                  onPressed: fnOnDeleteTap,
                  icon: Icon(Icons.delete),
                  label: Text('Eliminar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
