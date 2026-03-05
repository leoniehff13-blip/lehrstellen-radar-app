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

## Aktuelle Änderung: Tab-Navigation im Kontobildschirm

### Übersicht

Der Kontobildschirm wurde grundlegend überarbeitet und mit einer Tab-Navigation ausgestattet. Dies ermöglicht eine klare Trennung und eine intuitive Benutzerführung zwischen den persönlichen Profildetails und den eigenen Angeboten im Rahmen der Talentleihe.

### Implementierungsschritte

1.  **Umbau zu `StatefulWidget`:**
    *   Der `KontoScreen` wurde von einem `StatelessWidget` in ein `StatefulWidget` umgewandelt, um den Zustand des `TabController` verwalten zu können.
2.  **Implementierung der `TabBar`:**
    *   Eine `TabBar` mit den beiden Tabs "Mein Profil" und "Meine Angebote" wurde in die `AppBar` des `KontoScreen` integriert.
    *   Ein `TabController` wurde hinzugefügt, um die Synchronisation zwischen den Tabs und den zugehörigen Inhalten zu steuern.
3.  **Erstellung der `TabBarView`:**
    *   Die Inhalte für das Profil und die Angebote wurden in eine `TabBarView` verschoben.
    *   Der erste Tab zeigt die bekannten Profildetails an.
    *   Der zweite Tab enthält einen Platzhalter, der in Zukunft die Liste der Angebote des Nutzers anzeigen wird.
4.  **Optimierung der UI:**
    *   Der Titel der `AppBar` wurde zu "Mein Konto" geändert, um die neue, umfassendere Funktionalität widerzuspiegeln.
    *   Die Logik zur Anzeige des "Profil erstellen"-Zustands bleibt erhalten, wenn noch kein Profil vorhanden ist. In diesem Fall wird die `TabBar` ausgeblendet.

## Vorherige Änderungen

### Überarbeitung des Kontobildschirms

*   **UI-Anpassung des `KontoScreen`:**
    *   Die Datei `lib/screens/konto_screen.dart` wurde so angepasst, dass sie unterhalb der Profildetails einen neuen Bereich "Meine Angebote" anzeigt.

### Hinzufügen von Profilbildern

*   **Installation des `image_picker` Pakets.**
*   **Konfiguration für iOS.**
*   **Erweiterung des Datenmodells.**
*   **Implementierung der Bildauswahl.**
*   **Anzeige des Profilbilds.**
