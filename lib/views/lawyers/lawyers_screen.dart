import 'package:flutter/material.dart';
import 'package:lawyers_list/controller/lawers_controller.dart';
import 'package:provider/provider.dart';

class LawyersScreen extends StatelessWidget {
  const LawyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LawersController>(context, listen: false).getLawers();
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Consumer<LawersController>(builder: (context, value, _) {
      return value.lawersList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: Image.network(
                                value.lawersList![index].profilPicture!)
                            .image,
                      ),
                      title: Text(value.lawersList![index].name == ''
                          ? 'user'
                          : value.lawersList![index].name!),
                      subtitle: tileSubTitle(
                          value.lawersList![index].fieldOfExpertise!),
                      trailing: tileTrailing(
                          size: size,
                          rating: value.lawersList![index].ranking!),
                    ),
                  );
                },
                itemCount: value.lawersList!.length,
              ),
            );
    }));
  }

//trailing section
  SizedBox tileTrailing({required Size size, required String rating}) {
    return SizedBox(
      width: size.width * 0.12,
      child: Row(
        children: [Text(rating != '' ? rating : "0.0"), const Icon(Icons.star)],
      ),
    );
  }

//tile  section
  Row tileSubTitle(String field) {
    return Row(
      children: [
        const Icon(
          Icons.gavel_rounded,
          size: 15,
        ),
        Text(field == '' ? 'lawyer' : field),
      ],
    );
  }
}
