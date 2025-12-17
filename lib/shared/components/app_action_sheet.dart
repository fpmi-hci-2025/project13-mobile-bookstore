import 'dart:io';

import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppActionSheet {
  static void actionSheet(
    BuildContext context,
    Function() onPressed,
    String titleActionFirst,
    String titleActionSecond,
    IconData iconFirst,
    IconData iconSecond, {
    Function()? onPressedSecondAction,
    bool isProfile =false,
    String? titleProfileAction,
    IconData? iconProfileAction
  }) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: onPressed,
                child: Text(
                  titleActionFirst,
                  style: TextStyle(
                    fontSize: 17,
                    color:
                        isProfile == true
                            ? CupertinoColors.systemBlue
                            : CupertinoColors.systemRed,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (isProfile == true)
                CupertinoActionSheetAction(
                  onPressed: onPressedSecondAction!,
                  child: Text(
                    titleProfileAction!,
                    style: TextStyle(
                      fontSize: 17,
                      color: CupertinoColors.systemBlue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                titleActionSecond,
                style: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderSize16),
          ),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(iconFirst, color: Colors.grey),
                  title: Text(
                    titleActionFirst,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  onTap: onPressed,
                ),
                if (isProfile == true)
                ListTile(
                  leading: Icon(iconProfileAction, color: Colors.grey),
                  title: Text(
                   titleProfileAction!,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  onTap: onPressedSecondAction,
                ),
                ListTile(
                  leading: Icon(iconSecond, color: Colors.grey),
                  title: Text(
                    titleActionSecond,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
