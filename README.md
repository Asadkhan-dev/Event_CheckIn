1. App Startup and Internet Connection Check:
   Initial Internet Check: When the application starts, it checks the stability of the internet connection using the connectivity_plus package.
   Data Fetching:
   Stable Connection: If the internet connection is stable, the app fetches event data from an API and stores it locally in an SQLite database using sqflite. This ensures that the event data is available even if the user goes offline later.
   Unstable Connection: If there is no internet or it is unstable, the app continues to use the locally stored data for offline access.
2. Check-In Process:
   Internet Connection Check Before Check-In:

   Stable Connection: If the user is connected to a stable internet, their check-in is sent directly to Firebase. This real-time check-in data is updated in the remote database.
    Unstable Connection: If there is no internet connection at the time of check-in, the check-in data is saved locally on the device in the SQLite database.
    Syncing Check-Ins:

When the app is reopened and detects a stable internet connection, it syncs any locally stored check-ins with Firebase.
Duplicate Handling: Before syncing, the app checks Firebase to ensure the check-in doesn't already exist. If the check-in is already recorded in Firebase, it avoids storing it again, thus preventing duplicate entries.
3. Error Handling and Retry Mechanism:
   Error Handling During Data Fetching:
   When the app attempts to fetch data from the API and an error occurs (due to unstable internet or server issues), a retry button is provided to allow the user to manually retry the request.
4. Local Database Usage:
   Data Storage: The app uses the sqflite package to maintain a local database (events.db) to store event data and check-in information. This ensures the app remains fully functional in offline mode.
   Offline Access: The app displays event information from the local database when the internet is unavailable, providing a smooth user experience without interruptions.
5. Technical Stack:
   Internet Connectivity: Handled using the connectivity_plus package.
   API Data Fetching & Syncing: Managed using sqflite for local storage and Firebase for cloud storage.
   Retry Mechanism: Custom retry button for reattempting failed data fetches.