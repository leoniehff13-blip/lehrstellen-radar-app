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

## Aktuelle Änderung: Profil-Prüfung für 'Neuer Praxiseinsatz'

### Übersicht

Es wurde eine Prüfung implementiert, die sicherstellt, dass nur Betriebe mit einem angelegten Profil einen neuen Praxiseinsatz erstellen können. Ist kein Profil vorhanden, wird der Nutzer aufgefordert, eines zu erstellen, und wird direkt zur Profil-Erstellungsseite geleitet.

### Implementierungsschritte

1.  **Prüflogik hinzugefügt:** In der Methode `_handleNewPraxiseinsatz` in `lib/main.dart` wird nun überprüft, ob die Variable `_loggedInBetrieb` `null` ist.
2.  **Dialogfenster implementiert:** Wenn `_loggedInBetrieb` `null` ist, wird ein `AlertDialog` angezeigt.
3.  **Benutzerführung im Dialog:** Der Dialog informiert den Nutzer über das fehlende Profil und bietet zwei Optionen:
    *   **"Zum Profil":** Leitet den Nutzer zum "Konto"-Tab weiter, damit er sein Profil anlegen kann.
    *   **"Abbrechen":** Schließt den Dialog.
4.  **Bestehende Funktionalität beibehalten:** Ist ein Profil vorhanden, wird der Nutzer wie gewohnt zum Erstellungsformular für einen neuen Praxiseinsatz weitergeleitet.


## Vorherige Änderungen

### Fehlerbehebung auf dem Betriebslisten-Bildschirm

*   **Korrektur des `orElse`-Fallback:** In `lib/screens/betrieb_liste_screen.dart` wurde die `orElse`-Klausel korrigiert, um einen Absturz zu verhindern, wenn eine `handwerkskammerId` nicht gefunden wird. Es wird nun ein gültiges Fallback-Objekt erstellt.

### Fehlerbehebung auf dem Karten-Bildschirm

*   **Behebung eines Syntaxfehlers** in `lib/screens/karten_screen.dart` durch Ergänzen fehlender Kommas in den Testdaten.

### Fehlerbehebung in der Hauptansicht

*   **Korrektur der FAB-Logik:** Die Steuerung des Filter-Buttons wurde aus der zentralen `main.dart` entfernt und vollständig an die jeweiligen Listen-Bildschirme (`talent_liste_screen.dart` und `betrieb_liste_screen.dart`) übergeben.

### Erweiterte Filterfunktion für Betriebe

*   **Implementierung einer kombinierten Filterung** nach Gewerk, Ort, Handwerkskammer, Zeitraum und Aufgabenbeschreibung im "Betriebe"-Bildschirm.

### Erweiterte Filterfunktion für Talente

*   **Implementierung einer kombinierten Filterung** nach Fähigkeiten, Lehrjahr, Gewerk, Ort und Handwerkskammer im "Talente"-Bildschirm.

