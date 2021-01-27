import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(18, 12, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SkeletonAnimation(
                          shimmerColor: index % 2 != 0 ? Colors.grey : Colors.white38,
                          shimmerDuration: 2900,
                          borderRadius: BorderRadius.circular(4),
                          child: Text("   ",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          visible: index % 2 == 0,
                          child: SkeletonAnimation(
                            shimmerColor: index % 2 != 0 ? Colors.grey : Colors.white38,
                            shimmerDuration: 2950,
                            borderRadius: BorderRadius.circular(4),
                            child: Text("   ",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonAnimation(
                          shimmerColor: index % 2 != 0 ? Colors.grey : Colors.white38,
                          shimmerDuration: 2990,
                          borderRadius: BorderRadius.circular(4),
                          child: Text("   ",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Theme.of(context).hintColor)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Theme.of(context).hintColor,
                            icon: Icon(
                              Icons.share_outlined,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            color: Theme.of(context).hintColor,
                            icon: Icon(
                              Icons.comment_outlined,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(child: Divider(thickness: 1,color: Colors.black38,))
                ],
              ),
            ),

          ],
        );
      },
    );
  }
}
