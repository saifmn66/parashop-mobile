import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';

class SearchLocalDataSource {
  const SearchLocalDataSource(this._storage);

  final LocalStorageService _storage;

  List<String> getRecentSearches() =>
      _storage.getStringList(AppConstants.keyRecentSearches);

  List<String> getPopularSearches() => const [
        'Hyaluronic Acid',
        'SPF50+',
        'La Roche-Posay',
        'CeraVe Cleanser',
        'Vitamin D3',
        'Micellar Water',
        'Dry Oil',
        'Baby Wash',
      ];

  Future<List<String>> saveRecentSearches(List<String> terms) async {
    await _storage.setStringList(AppConstants.keyRecentSearches, terms);
    return terms;
  }
}
