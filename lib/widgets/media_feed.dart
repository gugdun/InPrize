import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprize/cubit/auth_cubit.dart';
import 'package:inprize/models/ig_media.dart';
import 'package:inprize/services/app_cache.dart';
import 'package:inprize/services/graph_api.dart';
import 'package:inprize/widgets/media_item.dart';

class MediaFeed extends StatelessWidget {
  const MediaFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, __) => false,
      builder: (BuildContext context, AuthState state) {
        return StreamBuilder(
          stream: GraphApi.instance
              .getUserMedia((state as AuthLoaded).userData?.id),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<IgMedia>> snapshot,
          ) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    CupertinoSliverRefreshControl(onRefresh: () async {
                      await AppCache.instance.setUserFeed(null);
                      GraphApi.instance.getUserMedia(state.userData?.id);
                    }),
                    SliverSafeArea(
                      sliver: SliverFillRemaining(
                        child: GridView.count(
                          physics: const ClampingScrollPhysics(),
                          crossAxisCount: 3,
                          children: snapshot.data!
                              .map((media) => MediaItem(media: media))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }
          },
        );
      },
    );
  }
}
