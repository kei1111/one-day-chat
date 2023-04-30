class FirestorePath {
  static String users() => 'users';
  static String user(String uid) => 'users/$uid';
  static String userProfile(String uid, String userProfileId) =>
      'users/$uid/userProfile/$userProfileId';
  static String userProfileList(String uid) => 'users/$uid/userProfile';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String filters(String uid) => 'users/$uid/entries';
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
