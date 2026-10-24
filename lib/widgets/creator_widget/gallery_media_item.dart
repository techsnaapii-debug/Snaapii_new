class GalleryMediaItem {
  final String path;
  final bool isAsset;
  final bool isVideo;

  const GalleryMediaItem({
    required this.path,
    this.isAsset = true,
    this.isVideo = false,
  });
}
