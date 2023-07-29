class User {
  final int? id;
  final String? name;
  final String? avatar;

  User({
    this.id,
    this.name,
    this.avatar,
  });
}

final User currentUser =
    User(id: 0, name: 'You', avatar: '/images/Addison.jpg');

final User addison =
    User(id: 1, name: 'Addison', avatar: '/images/Addison.jpg');

final User angel = User(id: 2, name: 'Angel', avatar: '/images/Angel.jpg');

final User deanna = User(id: 3, name: 'Deanna', avatar: '/images/Deanna.jpg');

final User jason = User(id: 4, name: 'Json', avatar: '/images/Jason.jpg');

final User judd = User(id: 5, name: 'Judd', avatar: '/images/Judd.jpg');

final User leslie = User(id: 6, name: 'Leslie', avatar: '/images/Leslie.jpg');

final User nathan = User(id: 7, name: 'Nathan', avatar: '/images/Nathan.jpg');

final User stanley =
    User(id: 8, name: 'Stanley', avatar: '/images/Stanley.jpg');

final User virgil = User(id: 9, name: 'Virgil', avatar: '/images/Virgil.jpg');
