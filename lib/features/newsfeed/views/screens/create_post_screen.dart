
import 'package:boilerplate/features/newsfeed/providers/newsfeed_provider.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:boilerplate/shared/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  TextEditingController textEditingController = TextEditingController();
  LinearGradient selectedFillColor = gradientsColor.first;
  int selectedColorIndex = 0;
  bool showColorList = true;

  static const List<LinearGradient> gradientsColor = [
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFFFFFFF),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFFff00ea),
        Color(0xFFff7300),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(-135),
      colors: [
        Color.fromRGBO(72, 229, 169, 1),
        Color.fromRGBO(143, 199, 173, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(116, 167, 126, 1),
        Color.fromRGBO(24, 175, 78, 1),
      ],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFff7f11),
        Color(0xFFff7f11),
      ],
    ),
    LinearGradient(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
      transform: GradientRotation(90),
      colors: [
        Color(0xFF00ffe1),
        Color(0xFFe9ff42),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close', style: fontMedium.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),
                  ),
                      
                  Text('Create Post', style: fontMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                      
                  Consumer(
                    builder: (context, watch, child) {
                      final newsFeedNotifier = ref.read(newsFeedProvider.notifier);
                      final newsFeedState = ref.watch(newsFeedProvider);
                      if(newsFeedState.isLoading) {
                        return Padding(
                          padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                              strokeWidth: 3,
                            ),
                          ),
                        );
                      }else{
                        return TextButton(
                        onPressed: () {
                          if(textEditingController.text.isNotEmpty) {
                            newsFeedNotifier.createPost(
                              context: context,
                              post: textEditingController.text,
                              selectedIndex: selectedColorIndex,
                            ).then((isSuccess) {
                              if(isSuccess) {
                                if(context.mounted) {
                                  Navigator.pop(context);
                                }
                            
                            }
                            });
                          }else{
                            showCustomSnackbar(message: 'Please enter some text', context: context, isError: true);
                          }
                        },
                        child: Text('Create', style: fontMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge)),
                      );
                      }
                      
                    }
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Container(
              decoration: BoxDecoration(
                gradient: selectedFillColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              ),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                  width: 0.3,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 0.3,
                  ),
                ),
                hintText: 'What\'s on your mind?',
                hintStyle: fontRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                  width: 0.3,
                  ),
                ),
                ),
                maxLines: 6,
              ),
              ),
            ),
            

            const SizedBox(height: Dimensions.paddingSizeDefault),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showColorList = !showColorList;
                      });
                    },
                    child: Container(
                      alignment: showColorList ? Alignment.centerRight : Alignment.center,
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      ),
                      child: Icon(showColorList ? Icons.arrow_back_ios : Icons.arrow_forward_ios, color: Theme.of(context).textTheme.bodyLarge!.color, size: 18,),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    if (showColorList)
                    Expanded(
                      child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(gradientsColor.length, (index) {
                        return GestureDetector(
                          onTap: () {
                          setState(() {
                            selectedFillColor = gradientsColor[index];
                            selectedColorIndex = index;
                          });
                          },
                          child: Container(
                          width: 26,
                          height: 26,
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            gradient: gradientsColor[index],
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                          ),
                          ),
                        );
                        }),
                      ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}