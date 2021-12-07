import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'coin-tracker.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE recent_visit_coin(id INTEGER PRIMARY KEY, name TEXT, img TEXT, time DATETIME)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertCoinRecent(CoinRecent coin) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'recent_visit_coin',
      coin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<CoinRecent>> getCoins() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('recent_visit_coin');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CoinRecent(
        id: maps[i]['id'],
        name: maps[i]['name'],
        img: maps[i]['img'],
        time: maps[i]['time'],
      );
    });
  }

  Future<void> updateCoinRecent(CoinRecent coin) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      coin.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [coin.id],
    );
  }

  Future<void> deleteCoinRecent(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'recent_visited_coin',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = CoinRecent(
    id: 0,
    name: 'Fido',
    img: '',
    time: DateTime.now()

  );

  await insertCoinRecent(fido);


  // Update Fido's age and save it to the database.
  fido = CoinRecent(
    id: fido.id,
    name: fido.name,
    img: fido.img,
    time: fido.time,
  );
  await updateCoinRecent(fido);
  print(await getCoins()); // Prints Fido with age 42.
  await deleteCoinRecent(fido.id);
}

class CoinRecent {
  final int id;
  final String name;
  final String img;
  final DateTime time;

  CoinRecent({
    required this.id,
    required this.name,
    required this.img,
    required this.time
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ìmg': img,
      'time': time
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, img: $img, time: $time}';
  }
}