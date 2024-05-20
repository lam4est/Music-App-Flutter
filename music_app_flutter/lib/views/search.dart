import 'package:flutter/material.dart';
import 'package:music_app_flutter/logic/mysql.dart';
import 'package:music_app_flutter/widgets/row_song_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final titleController = TextEditingController();
  List<Map<String, dynamic>> songs = [];
  bool isLoading = false;

  void searchSongs() async {
    setState(() {
      isLoading = true;
    });
    var db = Mysql();
    var results = await db.searchSongs(titleController.text);
    setState(() {
      songs = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16),
              const ListTile(
                title: Text(
                  "What do you want to listen to?",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Type something",
                  ),
                  onFieldSubmitted: (value) {
                    searchSongs();
                  },
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          var song = songs[index];
                          return SearchResult(song: song);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final Map<String, dynamic> song;

  const SearchResult({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(song['image'],
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(song['title']),
        subtitle: Text('Views: ${song['views']}'),
        trailing: IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            // Hành động khi bấm vào nút
            print('Playing ${song['title']}');
          },
        ),
        onTap: () {
          // Hành động khi bấm vào ListTile
          print('Tapped on ${song['title']}');
        },
      ),
    );
  }
}
