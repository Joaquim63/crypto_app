class ApiConstants {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';
  static const String searchEndpoint = '/search';
  static const String trendingEndpoint = '/search/trending';

  // Getter para o endpoint de detalhes de uma moeda específica
  static String getCoinDetailsEndpoint(String id) => '/coins/$id';

  static const String favoriteCryptosBoxName = 'favoriteCryptosBox';
}
