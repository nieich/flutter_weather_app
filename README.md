# Flutter Weather App 🌦️

Eine saubere und moderne Wetter-App, entwickelt mit Flutter. Sie zeigt das aktuelle Wetter, eine stündliche Vorhersage sowie eine 8-Tage-Vorhersage basierend auf dem aktuellen Standort des Nutzers an. Die App passt sich automatisch dem Hell- oder Dunkelmodus des Geräts an.

## Screenshots

Hier kannst du deine Screenshots einfügen, sobald du welche hast.

<table>
  <tr>
    <td align="center">
      <img src="<PLATZHALTER_FÜR_LIGHT_MODE_SCREENSHOT.png>" width="250" alt="Light Mode">
      <br>
      <strong>Light Mode</strong>
    </td>
    <td align="center">
      <img src="<PLATZHALTER_FÜR_DARK_MODE_SCREENSHOT.png>" width="250" alt="Dark Mode">
      <br>
      <strong>Dark Mode</strong>
    </td>
  </tr>
</table>

## Features

✅ **Aktuelles Wetter:** Zeigt detaillierte Informationen wie Temperatur, Luftfeuchtigkeit, Windgeschwindigkeit und mehr an.

✅ **Stündliche Vorhersage:** Eine scrollbare Liste mit der Wettervorhersage für die nächsten 24 Stunden.

✅ **Tägliche Vorhersage:** Ein Liniendiagramm mit der Min/Max-Temperaturvorhersage für die nächsten 8 Tage.

✅ **Automatische Standortermittlung:** Nutzt den Gerätestandort, um relevante Wetterdaten zu liefern.

✅ **Dynamisches Theme:** Wechselt automatisch zwischen Light- und Dark-Mode basierend auf den Systemeinstellungen.

✅ **API-Effizienz:** API-Aufrufe sind optimiert, um die Anzahl der Anfragen zu reduzieren und die Ladezeiten zu verkürzen (`Future.wait`).

## Verwendete API

Dieses Projekt nutzt die kostenlose und quelloffene Bright Sky API des Deutschen Wetterdienstes (DWD).

## Getting Started

Um das Projekt lokal auszuführen, befolge diese Schritte:

1.  **Klone das Repository:**
    ```sh
    git clone <DEIN_REPOSITORY_LINK>
    ```
2.  **Wechsle in das Projektverzeichnis:**
    ```sh
    cd flutter_weather_app
    ```
3.  **Installiere die Abhängigkeiten:**
    ```sh
    flutter pub get
    ```
4.  **Starte die App:**
    ```sh
    flutter run
    ```
