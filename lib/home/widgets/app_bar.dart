part of 'home_body.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final int currentTab;
  final void Function() fnOnCreateTap;
  final void Function() fnOnCompleteTap;
  final void Function() fnOnLogoutTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentTab,
    required this.fnOnCreateTap,
    required this.fnOnCompleteTap,
    required this.fnOnLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CircleAvatar(
        child: Image.asset('${AppConstants.imagesPath}logo.jpg'),
      ),
      title: Text(title),
      actions: <Widget>[
        IconButton(onPressed: fnOnLogoutTap, icon: Icon(Icons.logout)),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 8.0,
            children: <Widget>[
              Expanded(
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CustomColors.textSecondary,
                  ),
                ),
              ),
              OutlinedButton.icon(
                icon: Icon(Icons.add),
                label: Text(currentTab == 0 ? 'Crear' : 'Ingresar'),
                onPressed: currentTab == 0 ? fnOnCreateTap : fnOnCompleteTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
