part of 'home_body.dart';

class HomeBottomSheet extends StatelessWidget {
  final TabController tabController;

  const HomeBottomSheet({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 22.0,
        right: 22.0,
        bottom: 32.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[Tab(text: 'Mis encuestas'), Tab(text: 'Completadas')],
      ),
    );
  }
}
