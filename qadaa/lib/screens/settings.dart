import 'package:qadaa/Shared/Widgets/Tile.dart';
import 'package:flutter/material.dart';
import 'package:qadaa/manager/prayer_settings.dart';
import 'package:qadaa/manager/settings_manager.dart';
import 'package:qadaa/screens/dashboard.dart';
import 'package:qadaa/shared/dialogs/yes__no_popup.dart';
import 'package:qadaa/shared/widgets/user_text_field.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController? qadaaController = TextEditingController();
  @override
  void initState() {
    super.initState();

    qadaaController =
        TextEditingController(text: settingsManager.getqadaaEveryDay());
  }

  Widget count() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              child: Text(
                "عدد صلوات القضاء اليومية",
                textAlign: TextAlign.center,
              ),
            ),
            UserTextFieldChanged(
              controller: qadaaController!,
              hintText: "عدد صلوات القضاء اليومية ",
              onChange: (count) {
                setState(() {
                  if (count.isNotEmpty) {
                    setState(() {
                      settingsManager.setqadaaEveryDay(count);
                    });
                  }
                });
              },
            ),
            Text(
              prayersSettings.getEndDateText(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue.shade200),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("الإعدادات"),
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(
        children: [
          const Title(title: "عام"),
          count(),
          const Divider(),
          MyTile(
            title: 'صفحة البدء',
            icon: Icons.palette_outlined,
            onTap: () {
              setState(() {
                settingsManager.toggleSplashBackground();
              });
            },
            trailing: settingsManager.getSplashBackground(),
          ),
          MyTile(
            title: 'إعادة ضبط كل شيء',
            icon: Icons.delete_forever,
            trailing: "",
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return YesOrNoDialog(
                      onYes: () {
                        prayersSettings.reset();
                        settingsManager.resetqadaaEveryDay();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Dashboard()));
                      },
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(Icons.bookmark_border),

      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.pink),
      ),
    );
  }
}
