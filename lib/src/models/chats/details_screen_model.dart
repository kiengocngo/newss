class DetailsModel {
  final String userUid;
  final String friendUid;
  final String userName;
  final String friendName;
  final String userImage;
  final String friendImage;

  DetailsModel(
      {required this.userUid,
      required this.friendUid,
      required this.userName,
      required this.friendName,
      required this.userImage,
      required this.friendImage});
}
