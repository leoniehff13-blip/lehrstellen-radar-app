# Projekt: Azubi-Match - Vermittlungsplattform für Handwerks-Azubis

## Übersicht

Azubi-Match ist eine mobile Anwendung, die entwickelt wird, um Auszubildende im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Auszubildenden ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

## Geplante Funktionen

*   **Profile für Auszubildende:**
    *   Anzeige der bereits erlernten Fähigkeiten (dynamische Liste).
    *   Übersicht der noch zu absolvierenden Ausbildungsinhalte.
*   **Profile für Betriebe:**
    *   Darstellung der typischen Aufgaben und Tätigkeitsbereiche.
    *   Auflistung von Spezialisierungen.
    *   Angabe der Handwerkskammer.
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
8.  **Anpassung des Formulars "Neues Profil anlegen":**
    *   Implementierung einer dynamischen Eingabe für "Fähigkeiten" im Azubi-Profil, die das Hinzufügen und Entfernen mehrerer Fähigkeiten ermöglicht.
    *   Erweiterung des Formulars für Unternehmen um die Felder "Handwerkskammer" und "Spezialisierung".
    *   Umbenennung von "Betrieb" zu "Name des Betriebs".
    *   Optimierung des Layouts für Unternehmens- und Azubi-Profile durch Anordnung von Feldern in Zeilen (z.B. "Straße"/"Hausnummer", "Vorname"/"Name").
    *   Implementierung von Pflichtfeldern für Unternehmensprofile (alle außer Handwerkskammer/Spezialisierung) inklusive visueller Kennzeichnung (*) und Validierung.
    *   Umwandlung des Texthinweises zur Testphase in ein Info-Icon mit Dialogfenster für eine sauberere Oberfläche.
    *   Anpassung der Feld-Reihenfolge im Unternehmensprofil für eine bessere logische Gliederung (Gewerk und Ansprechperson nach oben verschoben).
9.  **Finalisierung:**
    *   Überprüfung aller Texte und Umstellung auf Deutsch.
    *   Feinschliff der Benutzeroberfläche und Fehlerbehebung.
