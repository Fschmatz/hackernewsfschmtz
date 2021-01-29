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
                          gradientColor: Colors.white38,
                          shimmerColor: Colors.grey.withOpacity(0.2),
                          shimmerDuration: 3100,
                          borderRadius: BorderRadius.circular(2),
                          child: Text("   ",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Visibility(
                          visible: index % 2 == 0,
                          child: SkeletonAnimation(
                            gradientColor: Colors.white38,
                            shimmerColor: Colors.grey.withOpacity(0.4),
                            shimmerDuration: 3120,
                            borderRadius: BorderRadius.circular(2),
                            child: Text("   ",
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        SkeletonAnimation(
                          gradientColor: Colors.white38,
                          shimmerColor: Colors.grey.withOpacity(0.5),
                          shimmerDuration: 3160,
                          borderRadius: BorderRadius.circular(2),
                          child: Text("   ",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Theme.of(context).hintColor)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_outlined,
                              color: Theme.of(context).accentColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Theme.of(context).hintColor,
                            icon: Icon(
                              Icons.comment_outlined,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            color: Theme.of(context).hintColor,
                            icon: Icon(
                              Icons.share_outlined,
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

//ANTIGO  shimmerColor: index % 2 != 0 ? Colors.grey : Colors.white38,