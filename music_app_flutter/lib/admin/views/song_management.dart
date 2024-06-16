import 'package:flutter/material.dart';
import 'package:music_app_flutter/admin/widgets/song_row_card.dart';
import 'package:music_app_flutter/logic/models/songs.dart';
import 'package:music_app_flutter/logic/mysql.dart';

class SongManagementView extends StatefulWidget {
  const SongManagementView({super.key});

  @override
  State<SongManagementView> createState() => _SongManagementViewState();
}

class _SongManagementViewState extends State<SongManagementView> {
  List<Song> songs = [];
  List<Song> filteredSongs = [];
  final Mysql _db = Mysql();

  @override
  void initState() {
    super.initState();
    fetchSongsFromDatabase();
  }

  Future<void> fetchSongsFromDatabase() async {
    var songData = await _db.getSongsbyAdmin('all');
    setState(() {
      songs = songData.map((data) => Song.fromMap(data)).toList();
      filteredSongs = songs;
    });
  }

  void searchSongs(String query) {
    setState(() {
      filteredSongs = songs
          .where(
              (song) => song.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> addSong(Song song) async {
    await _db.addSong(song);
    fetchSongsFromDatabase();
  }

  Future<void> editSong(Song updatedSong) async {
    await _db.editSong(updatedSong);
    fetchSongsFromDatabase();
  }

  Future<void> deleteSong(int id) async {
    await _db.deleteSong(id);
    fetchSongsFromDatabase();
  }

  Future<void> toggleSongActive(Song song) async {
    await _db.toggleSongActive(song.songID, song.active);
    fetchSongsFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage your songs',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 173, 181, 1.0)),
        ),
        backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 35,
              backgroundColor: Color.fromRGBO(0, 173, 181, 1.0),
              child: Icon(Icons.add,
                  color: Color.fromRGBO(238, 238, 238, 1.0), size: 25),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSongScreen(
                    onAdd: addSong,
                  ),
                ),
              );
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search songs',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: searchSongs,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
      body: ListView.builder(
        itemCount: filteredSongs.length,
        itemBuilder: (context, index) {
          final song = filteredSongs[index];
          return SongRowCard(
            song: song,
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSongScreen(
                    song: song,
                    onEdit: editSong,
                  ),
                ),
              );
            },
            onDelete: () {
              deleteSong(song.songID);
            },
            onToggleActive: () {
              toggleSongActive(song);
            },
          );
        },
      ),
    );
  }
}

class AddSongScreen extends StatefulWidget {
  final Function(Song) onAdd;

  const AddSongScreen({required this.onAdd, super.key});

  @override
  State<AddSongScreen> createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _imageController = TextEditingController();
  final _viewsController = TextEditingController();
  final _songUrlController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newSong = Song(
        songID: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        artist: _artistController.text,
        image: _imageController.text,
        views: int.parse(_viewsController.text),
        songUrl: _songUrlController.text,
        active: 0,
      );

      widget.onAdd(newSong);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Song'),
      ),
      backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _artistController,
                decoration: InputDecoration(labelText: 'Artist'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an artist';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _viewsController,
                decoration: InputDecoration(labelText: 'Views'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of views';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _songUrlController,
                decoration: InputDecoration(labelText: 'Song URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the song URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Song'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditSongScreen extends StatefulWidget {
  final Song song;
  final Function(Song) onEdit;

  const EditSongScreen({required this.song, required this.onEdit, super.key});

  @override
  State<EditSongScreen> createState() => _EditSongScreenState();
}

class _EditSongScreenState extends State<EditSongScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _imageController;
  late TextEditingController _viewsController;
  late TextEditingController _songUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.song.title);
    _artistController = TextEditingController(text: widget.song.artist);
    _imageController = TextEditingController(text: widget.song.image);
    _viewsController =
        TextEditingController(text: widget.song.views.toString());
    _songUrlController = TextEditingController(text: widget.song.songUrl);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedSong = Song(
        songID: widget.song.songID,
        title: _titleController.text,
        artist: _artistController.text,
        image: _imageController.text,
        views: int.parse(_viewsController.text),
        songUrl: _songUrlController.text,
        active: widget.song.active,
      );

      widget.onEdit(updatedSong);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Song'),
      ),
      backgroundColor: Color.fromRGBO(57, 62, 70, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _artistController,
                decoration: InputDecoration(labelText: 'Artist'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an artist';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _viewsController,
                decoration: InputDecoration(labelText: 'Views'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of views';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _songUrlController,
                decoration: InputDecoration(labelText: 'Song URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the song URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
