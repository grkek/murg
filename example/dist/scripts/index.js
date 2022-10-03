/*
 *
 *
 * Index.js - Contains the business logic for the main application component.
 *
 *
 */

fs.sprintf(mainBox.availableCallbacks)
fs.sprintf(mainWindow.availableCallbacks)
fs.sprintf(clickMe.availableCallbacks)

clickMe.buttonPress = function() {
  mainWindow.setTitle(randomUUID4())
  clickMe.setText(randomUUID4())
}