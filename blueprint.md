# Projekt: Azubi-Match - Vermittlungsplattform für Handwerks-Azubis

## Übersicht

Azubi-Match ist eine mobile Anwendung, die entwickelt wird, um Auszubildende im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Auszubildenden ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

## Geplante Funktionen

*   **Profile für Auszubildende:**
    *   Anzeige der bereits erlernten Fähigkeiten.
    *   Übersicht der noch zu absolvierenden Ausbildungsinhalte.
*   **Profile für Betriebe:**
    *   Darstellung der typischen Aufgaben und Tätigkeitsbereiche.
    *   Auflistung von Spezialisierungen.
*   **Darstellungsoptionen:**
    *   Listenansicht für Auszubildende und Betriebe.
    *   Kartenansicht zur geografischen Orientierung.
*   **Informationsseite:**
    *   Informationen zu den Handwerkskammern und dem ZDH.
*   **Sprache:** Deutsch
*   **Design:**
    *   **Farbpalette:** Blautöne (#D6DCE5, #002C59), Grau und Weiß.
    *   **Stil:** Modern, klar und benutzerfreundlich.

## Aktueller Umsetzungsplan

1.  **Grundstruktur und Theming:**
    *   Einrichtung der `MaterialApp` und des Haupt-Layouts.
    *   Implementierung des Farbschemas mittels `ThemeData`.
    *   Erstellung einer Startseite mit einer `BottomNavigationBar` für die Hauptbereiche (Auszubildende, Betriebe, Karte, Infos).
2.  **Installation von Paketen:**
    *   `google_maps_flutter` für die Kartenansicht.
    *   `provider` für das State Management (z.B. für den Theme-Wechsel oder die Verwaltung von App-Daten).
3.  **Erstellung der Bildschirm-Platzhalter:**
    *   `lib/screens/azubi_liste_screen.dart`
    *   `lib/screens/betrieb_liste_screen.dart`
    *   `lib/screens/karten_screen.dart`
    *   `lib/screens/info_screen.dart`
4.  **Implementierung der Navigation:**
    *   Aufbau der Navigation zwischen den einzelnen Bildschirmen.
5.  **Umsetzung der "Info"-Seite:**
    *   Einfügen von Platzhalter-Informationen für die Handwerkskammern und den ZDH.
6.  **Umsetzung der Listenansichten:**
    *   Erstellung von Datenmodellen für Auszubildende und Betriebe.
    *   Anzeige von Dummy-Daten in den Listen.
7.  **Umsetzung der Kartenansicht:**
    *   Einrichtung der `GoogleMap`-Ansicht.
    *   Hinzufügen von Markern für die Dummy-Daten.
8.  **Finalisierung:**
    *   Überprüfung aller Texte und Umstellung auf Deutsch.
    *   Feinschliff der Benutzeroberfläche und Fehlerbehebung.
