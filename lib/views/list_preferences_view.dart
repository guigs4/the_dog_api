import 'package:flutter/material.dart';
import 'package:the_dog_app/models/preferences_model.dart';
import 'package:the_dog_app/services/web_service.dart';
import '../widgets/preference_groups/sort_method_group.dart';

class ListPreferencesScreen extends StatefulWidget {
  const ListPreferencesScreen({super.key, required this.preferences});

  final PreferencesModel? preferences;

  @override
  _ListPreferencesScreenState createState() => _ListPreferencesScreenState();
}

class _ListPreferencesScreenState extends State<ListPreferencesScreen> {
  bool _isLoading = true;
  List<BreedInfo> _allBreeds = [];
  SortMethod _selectedSortMethod = SortMethod.random;
  BreedInfo? _selectedBreed = BreedInfo();
  dynamic _error;

  PreferencesModel? get _previousPreferences => widget.preferences;

  BreedInfo? get _previousBreed => _previousPreferences?.selectedBreed;
  SortMethod get _previousSortMethod =>
      _previousPreferences?.sortMethod ?? SortMethod.random;

  bool get _hasChangedSorting => _previousSortMethod != _selectedSortMethod;
  bool get _hasChangedBreed => _previousBreed != _selectedBreed;
  bool get _hasChangedPreferences => _hasChangedBreed || _hasChangedSorting;

  @override
  void initState() {
    _fetchFilterOptions();

    final previousPreferences = widget.preferences;
    if (previousPreferences != null) {
      _selectedSortMethod = previousPreferences.sortMethod;
      _selectedBreed = previousPreferences.selectedBreed;
    }

    super.initState();
  }

  //stolen from raywenderlich
  Future<void> _fetchFilterOptions() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final result = await WebService().fetchAllAvailableBreeds();
      setState(() {
        _allBreeds = result;
        _isLoading = false;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'List Preferences',
          ),
          actions: _hasChangedPreferences
              ? [
                  IconButton(
                    icon: const Icon(Icons.done),
                    onPressed: () {
                      _sendResultsBack(context);
                    },
                  )
                ]
              : null,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _error != null
                ? Text("Error: $_error") //TODO: change to a proper error indicator
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SortMethodGroup(
                          selectedItem: _selectedSortMethod,
                          onOptionTap: (option) => setState(
                            () => _selectedSortMethod = option,
                          ),
                        ),
                      ),
                      const Divider(),
                      const Divider(),
                    ],
                  ),
      );

  void _sendResultsBack(BuildContext context) {
    Navigator.of(context).pop(
      PreferencesModel(
        selectedBreed: _selectedBreed,
        sortMethod: _selectedSortMethod,
      ),
    );
  }
}

//TODO: Remove if unused
extension _Toggle<T> on List<T> {
  void toggleItem(T item) => contains(item) ? remove(item) : add(item);
}
