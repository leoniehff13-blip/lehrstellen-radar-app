# Projekt: Talentleihe - Vermittlungsplattform für Handwerks-Talente

## Übersicht

Talentleihe ist eine mobile Anwendung, die entwickelt wird, um Talente im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Talenten ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

## Stil, Design und Features

*   **Profile für Talente:**
    *   Anzeige der bereits erlernten Fähigkeiten (dynamische Liste).
    *   Übersicht der noch zu absolvierenden Ausbildungsinhalte.
*   **Profile für Betriebe:**
    *   Darstellung der typischen Aufgaben und Tätigkeitsbereiche.
    *   Auflistung von Spezialisierungen.
    *   Angabe der Handwerkskammer.
*   **Darstellungsoptionen:**
    *   Listenansicht für Talente und Betriebe.
    *   Kartenansicht zur geografischen Orientierung.
*   **Informationsseite:**
    *   Informationen zu den Handwerkskammern und dem ZDH.
*   **Sprache:** Deutsch
*   **Design:**
    *   **Farbpalette:** Blautöne (#D6DCE5, #002C59), Grau und Weiß.
    *   **Stil:** Modern, klar und benutzerfreundlich.

## Aktuelle Änderung: Refactoring von 'Azubi' zu 'Talent' und Fehlerbehebungen

### Übersicht

In diesem Schritt wurde die gesamte Anwendung überarbeitet, um die Terminologie von "Azubi" und "Azubi-Match" zu "Talent" und "Talentleihe" zu ändern. Dies schafft eine modernere und ansprechendere Nutzererfahrung. Zusätzlich wurden diverse Fehler behoben und die Codebasis stabilisiert.

### Implementierungsschritte

1.  **Grundstruktur und Theming:**
    *   Einrichtung der `MaterialApp` und des Haupt-Layouts.
    *   Implementierung des Farbschemas mittels `ThemeData`.
    *   Erstellung einer Startseite mit einer `BottomNavigationBar` für die Hauptbereiche (Auszubildende, Betriebe, Karte, Infos).
2.  **Installation von Paketen:**
    *   `google_maps_flutter` für die Kartenansicht.
    *   `provider` für das State Management (z.B. für den Theme-Wechsel oder die Verwaltung von App-Daten).
    *   `multi_select_flutter` für die Auswahl von Lernzielen.
    *   `intl` für die Datumsformatierung.
3.  **Erstellung der Bildschirm-Platzhalter:**
    *   `lib/screens/talent_liste_screen.dart` (früher `azubi_liste_screen.dart`)
    *   `lib/screens/betrieb_liste_screen.dart`
    *   `lib/screens/karten_screen.dart`
    *   `lib/screens/info_screen.dart`
    *   `lib/screens/konto_screen.dart`
    *   `lib/screens/neue_talentleihe_screen.dart` (früher `neuer_azubi_screen.dart`)
    *   `lib/screens/neuer_betrieb_screen.dart`
4.  **Implementierung der Navigation:**
    *   Aufbau der Navigation zwischen den einzelnen Bildschirmen.
5.  **Refactoring von 'Azubi' zu 'Talent':**
    *   Die Klasse `Azubi` in `lib/models/azubi.dart` wurde in `Talent` umbenannt und die Datei zu `lib/models/talent.dart` verschoben.
    *   Alle Bildschirme und Widgets wurden angepasst, um das neue `Talent`-Modell zu verwenden.
    *   Der App-Titel und die Bezeichnungen in der UI wurden von "Azubi Match" zu "Talentleihe" und von "Azubis" zu "Talente" geändert.
6.  **Anpassung des Formulars "Neues Profil anlegen":**
    *   Implementierung einer dynamischen Eingabe für "Fähigkeiten" im Talent-Profil.
    *   Erweiterung des Formulars für Unternehmen um die Felder "Handwerkskammer" und "Spezialisierung".
    *   Optimierung des Layouts für Unternehmens- und Talent-Profile.
    *   Implementierung von Pflichtfeldern und Validierung.
7.  **Fehlerbehebungen:**
    *   Behebung diverser Laufzeit- und Analysefehler.
    *   Korrektur von Tippfehlern und veralteten Referenzen.
8.  **Finalisierung:**
    *   Überprüfung aller Texte und Umstellung auf Deutsch.
    *   Feinschliff der Benutzeroberfläche.
