# Projekt: Talentleihe - Vermittlungsplattform für Handwerks-Talente

## Übersicht

Talentleihe ist eine mobile Anwendung, die entwickelt wird, um Talente im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Talenten ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

## Stil, Design und Features

*   **Profile für Talente:**
    *   Anzeige der bereits erlernten Fähigkeiten (dynamische Liste).
    *   Übersicht der noch zu absolvierenden Ausbildungsinhalte.
    *   Möglichkeit, ein Profilbild hochzuladen.
*   **Profile für Betriebe:**
    *   Darstellung der typischen Aufgaben und Tätigkeitsbereiche.
    *   Auflistung von Spezialisierungen.
    *   Angabe der Handwerkskammer.
    *   Möglichkeit, ein Firmenlogo oder ein Bild des Betriebs hochzuladen.
*   **Konto-Bildschirm:**
    *   Zentrale Anlaufstelle für das eigene Profil und die eigenen Angebote.
    *   Tab-Navigation zwischen "Mein Profil" und "Meine Angebote".
*   **Darstellungsoptionen:**
    *   Listenansicht für Talente und Betriebe.
    *   Kartenansicht zur geografischen Orientierung.
*   **Informationsseite:**
    *   Informationen zu den Handwerkskammern und dem ZDH.
*   **Sprache:** Deutsch
*   **Design:**
    *   **Farbpalette:** Blautöne (#D6DCE5, #002C59), Grau und Weiß.
    *   **Stil:** Modern, klar und benutzerfreundlich.

## Aktuelle Änderung: Fehlerbehebung auf dem Betriebslisten-Bildschirm

### Übersicht

Ein Syntaxfehler in der Datei `lib/screens/betrieb_liste_screen.dart` wurde behoben. Der Fehler war identisch mit einem zuvor auf dem Karten-Bildschirm behobenen Problem und verhinderte die korrekte Ausführung der App.

### Implementierungsschritte

1.  **Fehleranalyse:** Das Problem lag in den Testdaten für die `Betrieb`-Objekte. In den `aufgabenbereiche`-Listen fehlten die Kommas zur Trennung der einzelnen String-Einträge.
2.  **Fehlerbehebung:** Die fehlenden Kommas wurden in den `aufgabenbereiche`-Listen der `_allBetriebe`-Liste in `lib/screens/betrieb_liste_screen.dart` ergänzt, wodurch die Dart-Syntax wieder korrekt ist.


## Vorherige Änderungen

### Fehlerbehebung auf dem Karten-Bildschirm

*   **Behebung eines Syntaxfehlers** in `lib/screens/karten_screen.dart` durch Ergänzen fehlender Kommas in den Testdaten.

### Fehlerbehebung in der Hauptansicht

*   **Korrektur der FAB-Logik:** Die Steuerung des Filter-Buttons wurde aus der zentralen `main.dart` entfernt und vollständig an die jeweiligen Listen-Bildschirme (`talent_liste_screen.dart` und `betrieb_liste_screen.dart`) übergeben.

### Erweiterte Filterfunktion für Betriebe

*   **Implementierung einer kombinierten Filterung** nach Gewerk, Ort, Handwerkskammer, Zeitraum und Aufgabenbeschreibung im "Betriebe"-Bildschirm.

### Erweiterte Filterfunktion für Talente

*   **Implementierung einer kombinierten Filterung** nach Fähigkeiten, Lehrjahr, Gewerk, Ort und Handwerkskammer im "Talente"-Bildschirm.

