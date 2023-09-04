import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/comm/default_layout_widget.dart';
import 'package:ottugi_curry/view/page/ar_camera/ar_camera_page.dart';

class ArCameraPageTest extends StatelessWidget {
  const ArCameraPageTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutWidget(
        backToMain: true,
        appBarTitle: '챌린지 카메라',
        body: ExampleCard(
            example: Example(
                'Local & Online Objects',
                'Place 3D objects from Flutter assets and the web into the scene',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArCameraPage())))));
  }
}

class ExampleCard extends StatelessWidget {
  const ExampleCard({Key? key, required this.example}) : super(key: key);
  final Example example;

  @override
  build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          example.onTap();
        },
        child: ListTile(
          title: Text(example.name),
          subtitle: Text(example.description),
        ),
      ),
    );
  }
}

class Example {
  const Example(this.name, this.description, this.onTap);
  final String name;
  final String description;
  final Function onTap;
}
