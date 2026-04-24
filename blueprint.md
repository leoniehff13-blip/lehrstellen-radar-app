# Projekt: Win / Win - Vermittlungsplattform für Handwerks-Talente

## Übersicht

Win / Win ist eine mobile Anwendung, die entwickelt wird, um Talente im Handwerk mit passenden Betrieben zusammenzubringen. Die Plattform soll es Talenten ermöglichen, ihre Fähigkeiten und Lernfortschritte zu präsentieren, während Betriebe ihre Spezialisierungen und angebotenen Tätigkeiten darstellen können. Eine Kartenansicht soll die geografische Suche erleichtern.

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
*   **Anfragen-Funktionalität:**
    *   Betriebe können Talenten eine Anfrage senden.
    *   Talente sehen die erhaltenen Anfragen in ihrem Konto-Bereich.
    *   Möglichkeit, Anfragen anzunehmen oder abzulehnen (in Entwicklung).
*   **Konto-Bildschirm:**
    *   Zentrale Anlaufstelle für das eigene Profil, die eigenen Angebote und erhaltene Anfragen.
    *   Tab-Navigation zwischen "Mein Profil", "Meine Angebote" und "Meine Anfragen".
*   **Darstellungsoptionen:**
    *   Listenansicht für Talente und Betriebe mit Filterfunktionen.
    *   Kartenansicht zur geografischen Orientierung.
*   **Informationsseite:**
    *   Informationen zu den Handwerkskammern und dem ZDH.
*   **Sprache:** Deutsch
*   **Design:**
    *   **Farbpalette:** Blautöne (#D6DCE5, #002C59), Grau und Weiß.
    *   **Stil:** Modern, klar und benutzerfreundlich.

## Aktuelle Änderung: Implementierung der Anfragen-Funktionalität

### Übersicht

Eine Kernfunktion wurde implementiert, die es einem als **Unternehmen** registrierten Nutzer ermöglicht, eine Anfrage an ein **Talent** zu senden. Die Anfrage erscheint anschließend im Konto des Talents unter dem Reiter "Meine Anfragen".

### Implementierungsschritte

1.  **Datenmodell `Anfrage.dart` erstellt:** Ein neues Modell wurde unter `lib/models/anfrage.dart` angelegt, das den anfragenden Betrieb, das angefragte Talent und das Datum der Anfrage speichert.
2.  **Zentrales Anfragen-Management in `main.dart`:**
    *   Eine zentrale Liste `_anfragen` wurde hinzugefügt, um alle Anfragen zu verwalten.
    *   Die Funktion `_handleAnfrage` wurde erstellt. Sie fügt eine neue Anfrage hinzu und wird an die untergeordneten Widgets weitergereicht.
3.  **"Jetzt anfragen"-Button im `TalentDetailScreen.dart`:**
    *   Ein gelber `ElevatedButton` wurde zur Detailansicht eines Talents hinzugefügt.
    *   **Bedingte Anzeige:** Dieser Button ist **nur sichtbar**, wenn der angemeldete Nutzer ein Unternehmensprofil hat.
    *   Bei Klick wird die `_handleAnfrage`-Funktion aufgerufen und die Anfrage ausgelöst.
4.  **Anzeige der Anfragen im `KontoScreen.dart`:**
    *   Der "Konto"-Bildschirm wurde um den Reiter "Meine Anfragen" erweitert.
    *   Die `_buildAnfragenView`-Methode wurde implementiert, um eine Liste der erhaltenen Anfragen anzuzeigen. Jedes Element zeigt den Namen des anfragenden Betriebs und das Anfragedatum.
    *   Platzhalter-Buttons für "Annehmen" und "Ablehnen" wurden hinzugefügt.


## Vorherige Änderungen

### Profil-Prüfung für 'Neuer Praxiseinsatz'

*   **Prüflogik hinzugefügt:** In der Methode `_handleNewPraxiseinsatz` in `lib/main.dart` wird nun überprüft, ob die Variable `_loggedInBetrieb` `null` ist.

### Fehlerbehebung auf dem Betriebslisten-Bildschirm

*   **Korrektur des `orElse`-Fallback:** In `lib/screens/betrieb_liste_screen.dart` wurde die `orElse`-Klausel korrigiert, um einen Absturz zu verhindern, wenn eine `handwerkskammerId` nicht gefunden wird.

### Fehlerbehebung auf dem Karten-Bildschirm

*   **Behebung eines Syntaxfehlers** in `lib/screens/karten_screen.dart` durch Ergänzen fehlender Kommas in den Testdaten.

### Fehlerbehebung in der Hauptansicht

*   **Korrektur der FAB-Logik:** Die Steuerung des Filter-Buttons wurde aus der zentralen `main.dart` entfernt und vollständig an die jeweiligen Listen-Bildschirme (`talent_liste_screen.dart` und `betrieb_liste_screen.dart`) übergeben.

### Erweiterte Filterfunktion für Betriebe

*   **Implementierung einer kombinierten Filterung** nach Gewerk, Ort, Handwerkskammer, Zeitraum und Aufgabenbeschreibung im "Betriebe"-Bildschirm.

### Erweiterte Filterfunktion für Talente

*   **Implementierung einer kombinierten Filterung** nach Fähigkeiten, Lehrjahr, Gewerk, Ort und Handwerkskammer im "Talente"-Bildschirm.

