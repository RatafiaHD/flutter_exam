# Wizard Steps Design — Green Track

## Overview

Implement the 3 wizard steps of the carbon footprint calculator, a shared data model via Provider, and the wizard shell with navigation.

---

## Data Model

Single `WizardModel extends ChangeNotifier` in `lib/models/wizard_model.dart`.

### Transports
| Field | Type | Default |
|---|---|---|
| `carKm` | `int` | `12000` |
| `carPassengers` | `int` | `1` |
| `bikeType` | `BikeType?` | `null` |
| `bikeKm` | `int` | `1000` |

`BikeType` enum: `electric`, `mechanical`

### Housing
| Field | Type | Default |
|---|---|---|
| `housingType` | `HousingType?` | `null` |
| `housingSurface` | `int?` | `null` |
| `heatingSource` | `HeatingSource?` | `null` |

`HousingType` enum: `apartment`, `house`  
`HeatingSource` enum: `electricity`, `gas`, `wood`

### Consumption
| Field | Type | Default |
|---|---|---|
| `foodScore` | `int` | `0` |
| `equipmentScore` | `int` | `0` |

---

## Step 1 — Transports (`WizardStepTransports`)

### Section "En voiture"
- **Kilométrage** : `Slider` de 0 à 15 000. La dernière valeur affiche "15 000+". Label via `transports_car_km_value`.
- **Passagers en moyenne** : 5 boîtes cliquables côte à côte (1, 2, 3, 4, 5+). La boîte sélectionnée est mise en évidence (couleur `AppColors.primary`, texte blanc). Défaut : 1.

### Section "À vélo"
- **Type** : 2 `FilledButton` côte à côte ("Électrique" / "Musculaire"). Sélection exclusive, pas de valeur par défaut (null).
- **Kilométrage** : `Slider` de 0 à 10 000. La dernière valeur affiche "10 000+". Label via `transports_bike_km_value`.

---

## Step 2 — Logement (`WizardStepHousing`)

### Section "Caractéristiques"
- **Type** : 2 `FilledButton` côte à côte ("Appartement" / "Maison"). Sélection exclusive, pas de valeur par défaut (null).
- **Surface** : `TextField` entier > 0, hint "Ex : 30", suffix "m2". Pas de valeur par défaut (null).

### Section "Source de chauffage"
- 3 `RadioListTile` : "Électricité", "Gaz", "Bois". Pas de valeur par défaut (null).

---

## Step 3 — Consommation (`WizardStepConsumption`)

### Section "Alimentation"
- 2 `RadioListTile` : "Neuf" / "Occasion". Défaut : 0 → aucun sélectionné.

### Section "Équipements et textiles"
- 2 `RadioListTile` : "Neuf" / "Occasion". Défaut : 0 → aucun sélectionné.

---

## Wizard Shell (`WizardPage`)

- Devient `StatefulWidget`, gère `currentStep` (0, 1, 2).
- `GreenTrackAppBar` avec un `bottom` affichant l'indicateur d'étape via `current_step` (ex : "Étape 1 / 3").
- Corps : affiche le widget de l'étape courante (`WizardStepTransports`, `WizardStepHousing`, `WizardStepConsumption`).
- Barre de boutons en bas :
  - Étape 0 : bouton "Annuler" (gauche) + "Suivant" (droite)
  - Étape 1 : bouton "Précédent" (gauche) + "Suivant" (droite)
  - Étape 2 : bouton "Précédent" (gauche) + "Calculer" (droite)

---

## Provider Setup

`ChangeNotifierProvider<WizardModel>` wrapping `MaterialApp` in `main.dart`.

---

## File Structure

```
lib/
├── main.dart                          # Ajouter ChangeNotifierProvider
├── models/
│   └── wizard_model.dart              # WizardModel + enums
└── pages/
    └── wizard_page/
        ├── wizard_page.dart           # StatefulWidget + navigation
        └── step/
            ├── wizard_step_transports.dart
            ├── wizard_step_housing.dart
            └── wizard_step_consumption.dart
```

---

## Coding Constraints

- Utiliser uniquement `AppColors`, `AppIcons`, `AppLocalizations` pour couleurs, icônes et textes.
- Ne pas ajouter de dépendances.
- Style identique au code existant : `always_use_package_imports`, `prefer_single_quotes`, `const` constructors, `StatelessWidget` sauf nécessité.
- Pas de commentaires sauf si non-évident.
