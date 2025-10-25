part of 'home_body.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() fnOnLogoutTap;

  const CustomAppBar({super.key, required this.fnOnLogoutTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CircleAvatar(
        child: Image.asset('${AppConstants.imagesPath}logo.jpg'),
      ),
      actions: [IconButton(onPressed: fnOnLogoutTap, icon: Icon(Icons.logout))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
