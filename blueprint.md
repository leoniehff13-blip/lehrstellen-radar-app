# Projekt: Talentleihe - Vermittlungsplattform für Handwerks-Talente

## Übersicht

Talentleihe ist eine mobile Anwendung, die entwickelt wird, um Talente im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Talenten ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

## Stil, Design und Features

*   **Profile für Talente:**
    *   Anzeige der bereits erlernten Fähigkeiten.
    *   Übersicht der noch zu absolvierenden Ausbildungsinhalte.
*   **Profile für Betriebe:**
    *   Darstellung der typischen Aufgaben und Tätigkeitsbereiche.
    *   Auflistung von Spezialisierungen.
*   **Darstellungsoptionen:**
    *   Listenansicht für Talente und Betriebe.
    *   Kartenansicht zur geografischen Orientierung.
*   **Informationsseite:**
    *   Informationen zu den Handwerkskammern und dem ZDH.
*   **Sprache:** Deutsch
*   **Design:**
    *   **Farbpalette:** Blautöne (#D6DCE5, #002C59), Grau und Weiß.
    *   **Stil:** Modern, klar und benutzerfreundlich.

## Aktuelle Änderung: Refactoring von 'Azubi' zu 'Talent'

### Übersicht

In diesem Schritt wurde die gesamte Anwendung überarbeitet, um die Terminologie von "Azubi" und "Azubi-Match" zu "Talent" und "Talentleihe" zu ändern. Dies schafft eine modernere und ansprechendere Nutzererfahrung.

### Implementierungsschritte

1.  **Datenmodell aktualisiert:**
    *   Die Klasse `Azubi` in `lib/models/azubi.dart` wurde in `Talent` umbenannt.
    *   Die Datei wurde zu `lib/models/talent.dart` umbenannt.
2.  **Bildschirme für die Talent-Verwaltung umbenannt und angepasst:**
    *   `lib/screens/azubi_liste_screen.dart` wurde zu `lib/screens/talent_liste_screen.dart`.
    *   `lib/screens/azubi_detail_screen.dart` wurde zu `lib/screens/talent_detail_screen.dart`.
    *   Der Inhalt der Bildschirme wurde angepasst, um das neue `Talent`-Modell zu verwenden.
3.  **Haupt-Navigationsbildschirm aktualisiert:**
    *   `lib/screens/angebote_screen.dart` wurde zu `lib/screens/talentleihe_screen.dart` umbenannt.
    *   Der Titel wurde von "Angebote" zu "Talentleihe" geändert.
    *   Der Tab "Azubis" wurde in "Talente" umbenannt.
4.  **Zentrale App-Konfiguration angepasst:**
    *   Die `lib/main.dart` wurde aktualisiert, um die neuen Bildschirm-Namen zu importieren und zu verwenden.
    *   Der App-Titel wurde von "Azubi Match" zu "Talentleihe" geändert.
    *   Der Navigations-Tab-Label wurde von "Angebote" zu "Talentleihe" geändert.
5.  **Blueprint aktualisiert:**
    *   Dieses Dokument wurde aktualisiert, um die durchgeführten Änderungen widerzuspiegeln.
