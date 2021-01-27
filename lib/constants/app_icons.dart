enum AppIcons {
  close_circle,
  logout,
  empty,
  error,
}

const _AppIconsAsset = {
  AppIcons.close_circle: 'assets/assets/icons/close_circle.svg',
  AppIcons.logout: 'assets/assets/icons/logout.svg',
  AppIcons.error: 'assets/assets/icons/error.svg',
  AppIcons.empty: 'assets/assets/icons/empty.svg',
};

extension AppIconsExtension on AppIcons {
  String toAssetName() {
    final assets = _AppIconsAsset[this];
    if (assets != null) {
      return assets;
    }
    return 'assets/assets/icons/placeholder.svg';
  }
}
