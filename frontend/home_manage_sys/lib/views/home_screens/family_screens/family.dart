import 'package:flutter/material.dart';
import 'package:home_manage_sys/constants.dart';
import 'package:home_manage_sys/views/home_screens/family_screens/family_add.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(opacity: 0.2, child: Image.asset('assets/proj_image3.png', fit: BoxFit.cover,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text('Tasks', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text(
                  "Welcome to the Family Management page! Here, you can create and manage your family group within the app. Simply add your family members by creating a new family, and assign tasks to keep everything organized. Whether you're managing daily chores, special events, or important responsibilities, this feature ensures that everyone in the family stays on track and connected.",
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.add,
                      color: PrimaryColors.primaryColor4,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const FamilyAddPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColors.primaryColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                      )
                    ), 
                    label: Text(
                      'Add Family',
                      style: TextStyle(
                        color: PrimaryColors.primaryColor4
                      ),
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}