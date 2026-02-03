import 'dart:math';

class UnsplashService {
  // Biogas-related search terms for relevant images
  static const List<String> _biogasKeywords = [
    'biogas plant',
    'renewable energy',
    'green energy',
    'sustainable technology',
    'gas system',
    'energy installation',
    'environmental technology',
    'clean energy',
    'biomass energy',
    'alternative energy',
  ];

  // Service-specific keywords
  static const Map<String, List<String>> _serviceKeywords = {
    'setup': ['biogas installation', 'energy setup', 'plant construction'],
    'repair': ['biogas repair', 'maintenance', 'service technician'],
    'maintenance': ['biogas maintenance', 'plant service', 'energy upkeep'],
    'consultation': [
      'energy consultation',
      'biogas expert',
      'technical advisory'
    ],
    'emergency': ['emergency repair', 'biogas breakdown', 'urgent service'],
    'installation': [
      'system installation',
      'biogas setup',
      'plant construction'
    ],
    'purchase': ['biogas equipment', 'energy systems', 'green technology'],
  };

  /// Get a random biogas-related image URL
  static String getRandomBiogasImage() {
    final random = Random();
    final keyword = _biogasKeywords[random.nextInt(_biogasKeywords.length)];
    final width = 400 + random.nextInt(200); // 400-600px
    final height = 300 + random.nextInt(150); // 300-450px
    final seed = 'biogas_${random.nextInt(1000)}';

    return 'https://picsum.photos/seed/$seed/$width/$height.jpg';
  }

  /// Get a service-specific image URL
  static String getServiceImage(String serviceType) {
    final keywords =
        _serviceKeywords[serviceType.toLowerCase()] ?? _biogasKeywords;
    final random = Random();
    final keyword = keywords[random.nextInt(keywords.length)];
    final width = 400;
    final height = 300;
    final seed = '${serviceType.toLowerCase()}_${random.nextInt(1000)}';

    return 'https://picsum.photos/seed/$seed/$width/$height.jpg';
  }

  /// Get a carousel image URL
  static String getCarouselImage(int index) {
    final carouselKeywords = [
      'biogas technology',
      'renewable energy solutions',
      'sustainable living',
      'green energy future',
      'biogas innovation',
    ];

    final keyword = carouselKeywords[index % carouselKeywords.length];
    final seed = 'carousel_${index}_$keyword';
    return 'https://picsum.photos/seed/$seed/800/400.jpg';
  }

  /// Get a profile avatar URL
  static String getProfileAvatar() {
    final random = Random();
    final seed = 'biogas_technician_${random.nextInt(1000)}';
    return 'https://picsum.photos/seed/$seed/200/200.jpg';
  }

  /// Get a background image
  static String getBackgroundImage() {
    return 'https://picsum.photos/seed/biogas_background/1080/1920.jpg';
  }
}
