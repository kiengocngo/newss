class UserDetailsModel {
  final String image;
  final String currentUserName;
  final String currentUserUid;
  final String detailsUserUid;
  final String detailsUserName;
  final String detailsUserImage;

  UserDetailsModel({
    required this.currentUserName,
    required this.currentUserUid,
    required this.detailsUserUid,
    required this.detailsUserName,
    required this.detailsUserImage,
    required this.image,
  });
}
