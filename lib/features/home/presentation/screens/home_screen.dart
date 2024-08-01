import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/widgets/loader.dart';
import 'package:soundspace/core/common/widgets/show_snackber.dart';
import 'package:soundspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:soundspace/features/home/presentation/screens/homepage_screen.dart';

import '../../domain/entitites/track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("SpaceSpace"),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: AppPallete.whiteColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: 'Discovery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeTabPage();
  }
}

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Track> tracks = [];
  StreamController<List<Track>> trackStream = StreamController();
  @override
  void initState() {
    context.read<HomeBloc>().add(TrackLoadData());
    observeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is TrackFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: ((context, state) {
          if (state is HomeLoading) {
            return const Loader();
          }
          if (state is TrackSuccess) {
            trackStream.add(state.tracks!);
            return getListView();
          }
          return const SizedBox();
        }),
      ),
    );
  }

  @override
  void dispose() {
    trackStream.close();
    super.dispose();
  }

  ListView getListView() {
    return ListView.separated(
      itemBuilder: (context, position) {
        return getRow(position);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: AppPallete.borderColor,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: tracks.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    return _TrackItemSection(parent: this, track: tracks[index]);
  }

  void observeData() {
    trackStream.stream.listen((trackList) {
      setState(() {
        tracks.addAll(trackList);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 400,
            color: AppPallete.borderColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Model Button Sheet'),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close Bottom Sheet"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void navigate(Track track) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(
        tracks: tracks,
        playingTrack: track,
      );
    }));
  }
}

class _TrackItemSection extends StatelessWidget {
  const _TrackItemSection({
    required this.parent,
    required this.track,
  });
  final _HomeTabPageState parent;
  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 8, left: 24),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/ITunes_12.2_logo.png',
          image: track.image,
          width: 48,
          height: 48,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/ITunes_12.2_logo.png',
              width: 48,
              height: 48,
            );
          },
        ),
      ),
      title: Text(track.title),
      subtitle: Text(track.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          parent.showBottomSheet();
        },
      ),
      onTap: () {
        parent.navigate(track);
      },
    );
  }
}
