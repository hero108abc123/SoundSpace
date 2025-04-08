import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/add_to_playlist.dart';

class UserArtist extends StatefulWidget {
  final Artist track;
  final Playlist playlist;
  final Function(Artist) onNavigate;

  const UserArtist({
    Key? key,
    required this.track,
    required this.playlist,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _UserArtistState createState() => _UserArtistState();
}

class _UserArtistState extends State<UserArtist> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: AppBar(
          flexibleSpace: _buildHeader(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPallete.gradient2,
              AppPallete.gradient4,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Profile'),
                Tab(text: 'Songs'),
              ],
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              indicatorColor: Colors.white,
              isScrollable: true,
              unselectedLabelColor: const Color.fromARGB(255, 138, 138, 138),
              labelColor: Colors.white,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProfileArtist(context),
                  _buildSongArtist(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.track.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.03,
          left: 20,
          child: IconButton(
            icon: Image.asset(
              'assets/images/icon/playlist/icon Back.png',
              color: Colors.white,
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            widget.track.displayName,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Follow',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 44, 44, 44),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _buildProfileArtist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.track.followersCount} followers • ${widget.track.followingCount} following',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Display Name: ${widget.track.displayName}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Age: ', 
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Gender: ', 
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.track.displayName}\'s playlists created',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'See More',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Phần hiển thị playlist
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                // children: playlists.map((playlist) {
                //   return Padding(
                //     padding: const EdgeInsets.only(left: 20),
                //     child: TrackItem(
                //       track: playlist,
                //       onNavigate: (Playlist playlist) {
                //         widget.onNavigate(playlist);
                //       },
                //     ),
                //   );
                // }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSongArtist(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildSongItem('Song 1'),
          _buildSongItem('Song 2'),
          _buildSongItem('Song 3'),
        ],
      ),
    );
  }


  Widget _buildSongItem(String songName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.asset(
              'assets/images/Billielish3.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('assets/images/icon/home/icon_play.png', width: 26, height: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/images/icon/home/icon_dot.png', width: 26, height: 26),
            onPressed: () {
              _showModalBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/Billielish3.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Cùng đánh thôi',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'Đức Phúc',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset('assets/images/icon/home/icon_add.png', width: 26, height: 26),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToPlaylist(playlist: widget.playlist), 
                        ),
                      );
                    },
                  ),
                  Text(
                    'Add to playlist',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}