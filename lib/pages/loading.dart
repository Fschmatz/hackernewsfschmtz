import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = WidgetsBinding.instance.window.physicalSize.height;
    int valueTilesLoading = (deviceHeight / 400).round();

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: valueTilesLoading,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(6, index == 0 ? 0 : 20, 3, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              18, index == 0 ? 10 : 0, 18, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SkeletonAnimation(
                                key: UniqueKey(),
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.2),
                                shimmerDuration: 3550,
                                borderRadius: BorderRadius.circular(8),
                                child: const Text("   ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Visibility(
                                visible: index % 2 == 0,
                                child: SkeletonAnimation(
                                  key: UniqueKey(),
                                  gradientColor: Colors.white38,
                                  shimmerColor: Colors.grey.withOpacity(0.4),
                                  shimmerDuration: 3980,
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Text("   ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SkeletonAnimation(
                                key: UniqueKey(),
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.5),
                                shimmerDuration: 4360,
                                borderRadius: BorderRadius.circular(8),
                                child: Text("   ",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.article_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 38,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.mode_comment_outlined,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme.onSecondary,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary:
                                            Theme.of(context).cardTheme.color,
                                        onPrimary:
                                            Theme.of(context).colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
