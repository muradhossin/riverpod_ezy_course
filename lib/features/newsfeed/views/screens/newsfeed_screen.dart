import 'dart:async';
import 'dart:developer';
import 'package:boilerplate/core/extensions/image_path.dart';
import 'package:boilerplate/core/routes/routes.dart';
import 'package:boilerplate/features/login/controllers/login_provider.dart';
import 'package:boilerplate/features/login/views/widgets/logout_dialog_widget.dart';
import 'package:boilerplate/features/newsfeed/providers/newsfeed_provider.dart';
import 'package:boilerplate/features/newsfeed/views/widgets/header_widget.dart';
import 'package:boilerplate/features/newsfeed/views/widgets/post_input_field_widget.dart';
import 'package:boilerplate/features/newsfeed/views/widgets/post_view_widget.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewsfeedScreen extends ConsumerStatefulWidget {
  const NewsfeedScreen({super.key});

  @override
  ConsumerState<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends ConsumerState<NewsfeedScreen> {
  TextEditingController textEditingController = TextEditingController();
  int currentIndex = 0;
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiCall();
    _scrollController.addListener(_onScroll);
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      apiCall();
    });
  }

  Future<void> apiCall() async {
    final newsFeedNotifier = ref.read(newsFeedProvider.notifier);
    final newsFeedState = ref.read(newsFeedProvider);
    if (newsFeedState.newsFeedList != null && newsFeedState.newsFeedList!.isNotEmpty) {
      final lastFeedId = newsFeedState.newsFeedList!.last.id;
      newsFeedNotifier.getNewsfeedList(isUpdate: false, lastFeedId: lastFeedId.toString());
    }else {
      newsFeedNotifier.getNewsfeedList(isUpdate: false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 1000) {
      final newsFeedNotifier = ref.read(newsFeedProvider.notifier);
      final newsFeedState = ref.read(newsFeedProvider);
      if (newsFeedState.newsFeedList != null && newsFeedState.newsFeedList!.isNotEmpty) {
        final lastFeedId = newsFeedState.newsFeedList!.last.id;
        newsFeedNotifier.getNewsfeedList(isUpdate: false, lastFeedId: lastFeedId.toString());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsFeedState = ref.watch(newsFeedProvider);
    final newsFeedNotifier = ref.read(newsFeedProvider.notifier);
    return RefreshIndicator(
      onRefresh: () async {
        await newsFeedNotifier.getNewsfeedList(isUpdate: true);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(156),
          child: HeaderWidget(),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              PostInputFieldWidget(textEditingController: textEditingController, onPressed: () {
                context.pushNamed(Routes.createPost);
              }),
              if (newsFeedState.isLoading || newsFeedState.newsFeedList == null) ...[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ] else if ((newsFeedState.newsFeedList != null && newsFeedState.newsFeedList!.isEmpty)) ...[
                Center(
                  child: Text('No posts found'),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsFeedState.newsFeedList!.length,
                  itemBuilder: (context, index) {
                    final newsfeed = newsFeedState.newsFeedList![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                      child: PostViewWidget(
                        newsFeedModel: newsfeed,
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            if (index == 1) {
              showDialog(
                context: context,
                builder: (context) => LogoutDialogWidget(
                  onLogout: () async {
                    final loginNotifier = ref.read(loginProvider.notifier);
                    await loginNotifier.logout();
                    if (context.mounted) {
                      context.goNamed(Routes.login);
                    }
                  },
                ),
              );
              return;
            }
            setState(() {
              currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CustomImage(
                width: 24,
                height: 24,
                imagePath: Images.communityIcon,
              ),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: CustomImage(
                width: 24,
                height: 24,
                imagePath: Images.logoutIcon,
              ),
              label: 'Logout',
            ),
          ],
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}