import '../../flutter_google_maps.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home View"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //*
            ElevatedButton(
              onPressed: () => Get.to(() => const LocationView()),
              child: const Text("Go To Map View"),
            ),
          ],
        ),
      ),
    );
  }
}
