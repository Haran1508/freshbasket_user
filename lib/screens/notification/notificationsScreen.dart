import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:get/get.dart';
import 'noshedule.dart';
import 'notification.ctrl.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        title: Text("Notifications"),
        centerTitle: true,
        actions: [
          // ElevatedButton(
          //   onPressed: () {
          //     Map<String, dynamic> dataValue = {
          //       "title": "Notification 1",
          //       "message": "Raw Milk 1Ltr has been delivered at 7.30 A.M"
          //     };
          //     notificationController.savetoDb(dataValue);
          //   },
          //   child: Icon(Icons.delete_outline),
          // ),
          Obx(
            () => InkWell(
              onTap: (notificationController.notificationsList.length > 0)
                  ? () => notificationController.clearAll()
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [Icon(Icons.clear_all), Text("Clear All")],
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (notificationController.notificationsList.length < 0)
          return Center(
            child: NoScheduleOrder(content: "No notifications found"),
          );
        return ListView.builder(
          itemCount: 5, //notificationController.notificationsList.length,
          itemBuilder: (context, index) {
            // NotificationModel data =
            //     notificationController.notificationsList[index];
            return Dismissible(
              onDismissed: (value) {
                //notificationController.deleteNotification(index);
                notificationController.notificationsList.removeAt(index);
              },
              direction: DismissDirection.startToEnd,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.delete,
                      color: kBackgroudColor // kBackgroudColor,
                      ),
                ),
              ),
              //key: Key(data.id.toString()),
              key: UniqueKey(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 1),
                  ),
                ),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kPrimaryYellow.withOpacity(0.2),
                      child: Icon(
                        Icons.notifications,
                        color: kPrimaryYellow,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Id",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("12-Sep-2021", style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                    subtitle: Text('Order placed successfully')),
              ),
            );
          },
          //separatorBuilder: (BuildContext context, int index) => Divider()
        );
      }),
    );
  }
}
