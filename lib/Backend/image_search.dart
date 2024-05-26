import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Search App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _keywordController = TextEditingController();
  String _folderPath = "";
  Future<List<Map<String, dynamic>>>? _searchResults;
  bool _isIndexing = false;

  Future<void> _pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      setState(() {
        _folderPath = selectedDirectory;
      });
      await _setImageFolderAndIndex();
    }
  }

  Future<void> _setImageFolderAndIndex() async {
    if (_folderPath.isEmpty) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/set_image_folder'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'image_folder': _folderPath}),
      );

      if (response.statusCode == 200) {
        await _indexImages();
      } else {
        throw Exception('Failed to set image folder');
      }
    } catch (e) {
      print('Error setting image folder: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to set image folder')));
    }
  }

  Future<void> _indexImages() async {
    setState(() {
      _isIndexing = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Indexing images..."),
            ],
          ),
        );
      },
    );

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/index_images'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Images indexed successfully.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Images indexed successfully')));
      } else {
        throw Exception('Failed to index images');
      }
    } catch (e) {
      print('Error indexing images: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to index images')));
    } finally {
      setState(() {
        _isIndexing = false;
      });
      Navigator.of(context).pop();  // Dismiss the loading dialog
    }
  }

  Future<List<Map<String, dynamic>>> _searchImages() async {
    final keyword = _keywordController.text;
    if (keyword.isEmpty) {
      return [];
    }

    try {
      final response = await http.get(Uri.parse('http://localhost:5000/search_images?keyword=$keyword'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => {
          'image_path': item[0],
          'caption': item[1],
          'similarity': item[2]
        }).toList();
      } else {
        throw Exception('Failed to search images');
      }
    } catch (e) {
      print('Error searching images: $e');
      return [];
    }
  }

  void _refreshSearch() {
    setState(() {
      _keywordController.clear();
      _searchResults = null;
    });
  }

  void _onSearchPressed() {
    setState(() {
      _searchResults = _searchImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _folderPath.isEmpty ? 'No folder selected' : _folderPath,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.folder_open),
                  onPressed: _pickFolder,
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(
                labelText: 'Enter keyword',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _onSearchPressed,
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _refreshSearch,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No results found.');
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final result = snapshot.data![index];
                        if (result['similarity'] > 0.35) {
                          return Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    'http://localhost:5000/images/${Uri.encodeComponent(result['image_path'])}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(child: Icon(Icons.error));
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(result['caption']),
                                  subtitle: Text('Similarity: ${result['similarity'].toStringAsFixed(4)}'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox.shrink(); // Hide if similarity is less than 0.35
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
