// Project Models
import 'package:sfrigola/core/models/user.dart';

// ---------------------------------------------------------------------------
// Mock users — one per [UserType].
// Maintained manually; used by BeSimulators as seed for the mutable _authUsers
// list. Do NOT auto-generate this file.
//
// Credentials:
//   admin@sfrigola.it  /  Admin123!
//   chef@sfrigola.it   /  Chef123!
//   user@sfrigola.it   /  User123!
// ---------------------------------------------------------------------------

const mockUsers = [
  {
    'id': 'u1',
    'name': 'Mario',
    'surname': 'Rossi',
    'email': 'admin@sfrigola.it',
    'type': UserType.admin,
    'password': 'Admin123!',
    'token': 'mock-token-admin-u1',
  },
  {
    'id': 'u2',
    'name': 'Luca',
    'surname': 'Bianchi',
    'email': 'chef@sfrigola.it',
    'type': UserType.chef,
    'password': 'Chef123!',
    'token': 'mock-token-chef-u2',
  },
  {
    'id': 'u3',
    'name': 'Giulia',
    'surname': 'Verdi',
    'email': 'user@sfrigola.it',
    'type': UserType.consumer,
    'password': 'User123!',
    'token': 'mock-token-consumer-u3',
  },
];
