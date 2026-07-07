
class RegionOverlayHelper {
  static const Map<String, String> overlays = {
    'Автономна Республіка Крим':
        'assets/images/map/overlays/Krym.png',
    'м. Севастополь':
        'assets/images/map/overlays/Sevastopol.png',
    'Київ':
        'assets/images/map/overlays/Kyiv.png',
    'Київська область':
        'assets/images/map/overlays/Kyivska.png',
    'Вінницька область':
        'assets/images/map/overlays/Vinnytska.png',
    'Волинська область':
        'assets/images/map/overlays/Volynska.png',
    'Дніпропетровська область':
        'assets/images/map/overlays/Dnipropetrovska.png',
    'Донецька область':
        'assets/images/map/overlays/Donetska.png',
    'Житомирська область':
        'assets/images/map/overlays/Zhitomirska.png',
    'Закарпатська область':
        'assets/images/map/overlays/Zakarpatska.png',
    'Запорізька область':
        'assets/images/map/overlays/Zaporizka.png',
    'Івано-Франківська область':
        'assets/images/map/overlays/Ivanj-frankivska.png',
    'Кіровоградська область':
        'assets/images/map/overlays/KIrovogradska.png',
    'Луганська область':
        'assets/images/map/overlays/Luhanska.png',
    'Львівська область':
        'assets/images/map/overlays/Lvivska.png',
    'Миколаївська область':
        'assets/images/map/overlays/Mukolayivska.png',
    'Одеська область':
        'assets/images/map/overlays/Odeska.png',
    'Полтавська область':
        'assets/images/map/overlays/Poltavska.png',
    'Рівненська область':
        'assets/images/map/overlays/Rivnenska.png',
    'Сумська область':
        'assets/images/map/overlays/Sumska.png',
    'Тернопільська область':
        'assets/images/map/overlays/Ternopilska.png',
    'Харківська область':
        'assets/images/map/overlays/Kharkivska.png',
    'Херсонська область':
        'assets/images/map/overlays/Khersonska.png',
    'Хмельницька область':
        'assets/images/map/overlays/Khelnyska.png',
    'Черкаська область':
        'assets/images/map/overlays/Cherkaska.png',
    'Чернівецька область':
        'assets/images/map/overlays/Chernivetska.png',
    'Чернігівська область':
        'assets/images/map/overlays/Chernihivska.png',
  };

  static String? getOverlay(String regionName) {
    return overlays[regionName];
  }
}
