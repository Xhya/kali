import 'package:kali/core/models/NutriScore.model.dart';

final emptyNutriScore = NutriScore(
  id: "1",
  proteinAmount: 0,
  lipidAmount: 0,
  glucidAmount: 0,
  caloryAmount: 0,
);

final fixtureNutriScore1 = NutriScore(
  id: "0",
  proteinAmount: 30,
  lipidAmount: 20,
  glucidAmount: 50,
  caloryAmount: 122,
  thinking: thinking1,
);

final fixtureNutriScore2 = NutriScore(
  id: "1",
  proteinAmount: 50,
  lipidAmount: 40,
  glucidAmount: 100,
  caloryAmount: 544,
);

final fixturePersonalNutriScore = NutriScore(
  id: "2",
  proteinAmount: 120,
  lipidAmount: 70,
  glucidAmount: 130,
  caloryAmount: 2000,
);

final thinking1 =
    '''Pour estimer les apports nutritionnels quotidiens nécessaires, plusieurs facteurs sont à prendre en compte : l'âge, le sexe, la taille, le poids actuel, le niveau d'activité physique et l'objectif de poids.

1. **Calcul du métabolisme de base (MB)** :
   Pour une femme, la formule de Mifflin-St Jeor est utilisée :
   \[
   MB = 10 \times \text{poids (kg)} + 6.25 \times \text{taille (cm)} - 5 \times \text{âge (ans)} - 161
   \]
   - Âge : 2025 - 1988 = 37 ans
   - Poids : 80 kg
   - Taille : 170 cm
   - MB = 10 × 80 + 6.25 × 170 - 5 × 37 - 161
   - MB = 800 + 1062.5 - 185 - 161 = 1516.5 kcal/jour

2. **Ajustement pour le niveau d'activité** :
   Le rythme de vie est principalement assis, ce qui correspond à un facteur d'activité de 1.2 (sédentaire).
   \[
   \text{Dépense énergétique totale} = MB \times 1.2 = 1516.5 \times 1.2 = 1819.8 \text{ kcal/jour}
   \]

3. **Ajustement pour l'objectif de poids** :
   L'objectif est de perdre du poids (passer de 80 kg à 70 kg). Une perte de poids saine est généralement de 0.5 à 1 kg par semaine, ce qui correspond à un déficit calorique de 500 à 1000 kcal par jour. Ici, un déficit modéré de 500 kcal/jour est choisi.
   \[
   \text{Apport calorique quotidien} = 1819.8 - 500 = 1319.8 \text{ kcal/jour}
   \]
   Arrondi à 1320 kcal/jour.

4. **Répartition des macronutriments** :
   Pour une perte de poids, une répartition commune est :
   - Protéines : 30% des calories
   - Glucides : 40% des calories
   - Lipides : 30% des calories

   Calcul des grammes pour chaque macronutriment :
   - Protéines : (1320 × 0.30) / 4 = 99 g
   - Glucides : (1320 × 0.40) / 4 = 132 g
   - Lipides : (1320 × 0.30) / 9 = 44 g

   Les valeurs sont arrondies à l'unité près.
''';
