import 'package:flutter/material.dart';

class AppColors {
  // LIGHT THEME COLORS
  static Color primary = const Color.fromARGB(255, 204, 0, 0);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = const Color(0xff444444);
  static Color error = const Color(0xffff0000);

  // DARK THEME COLORS
  static Color primaryDark = const Color.fromARGB(255, 204, 0, 0);
  static Color whiteDark = const Color(0xff111111);
  static Color blackDark = Colors.white;
  static Color greyDark = const Color(0xffAAAAAA);
  static Color errorDark = const Color(0xffff0000);
}

class PokemonColors {
  static Color normal = const Color(0xFFA8A77A);
  static Color fire = const Color(0xFFEE8130);
  static Color water = const Color(0xFF6390F0);
  static Color electric = const Color(0xFFF7D02C);
  static Color grass = const Color(0xFF7AC74C);
  static Color ice = const Color(0xFF96D9D6);
  static Color fighting = const Color(0xFFC22E28);
  static Color poison = const Color(0xFFA33EA1);
  static Color ground = const Color(0xFFE2BF65);
  static Color flying = const Color(0xFFA98FF3);
  static Color psychic = const Color(0xFFF95587);
  static Color bug = const Color(0xFFA6B91A);
  static Color rock = const Color(0xFFB6A136);
  static Color ghost = const Color(0xFF735797);
  static Color dragon = const Color(0xFF6F35FC);
  static Color dark = const Color(0xFF705746);
  static Color steel = const Color(0xFFB7B7CE);
  static Color fairy = const Color(0xFFD685AD);

  static getPokemonColor(String type) {
    switch (type) {
      case 'fire':
        return fire;
      case 'water':
        return water;
      case 'grass':
        return grass;
      case 'electric':
        return electric;
      case 'ice':
        return ice;
      case 'fighting':
        return fighting;
      case 'poison':
        return poison;
      case 'ground':
        return ground;
      case 'flying':
        return flying;
      case 'psychic':
        return psychic;
      case 'bug':
        return bug;
      case 'rock':
        return rock;
      case 'ghost':
        return ghost;
      case 'dragon':
        return dragon;
      case 'dark':
        return dark;
      case 'steel':
        return steel;
      case 'fairy':
        return fairy;
      default:
        return AppColors.primary;
    }
  }
}