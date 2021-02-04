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
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(18, 15, 18, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SkeletonAnimation(
                          gradientColor: Colors.white38,
                          shimmerColor: Colors.grey.withOpacity(0.2),
                          shimmerDuration: 3100,
                          borderRadius: BorderRadius.circular(5),
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
                            borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.text_snippet_outlined, //article
                                  color: Theme.of(context).accentColor,
                                  size: 18,
                                ),
                                SizedBox(width: 30,),
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: Theme.of(context).accentColor,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.5),
                                shimmerDuration: 3160,
                                borderRadius: BorderRadius.circular(5),
                                child: Text("                               ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).hintColor)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.comment_outlined,
                                            size: 20,
                                            color: Theme.of(context).hintColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                        ],
                                      ),
                                      ),
                                  MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      minWidth: 0,
                                      child: Icon(
                                        Icons.share_outlined,
                                        size: 20,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                  Container(child: Divider(thickness: 1,color: Colors.black,))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
