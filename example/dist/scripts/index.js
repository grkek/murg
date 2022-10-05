/*
 *
 *
 * Index.js - Contains the business logic for the main application component.
 *
 *
 */

fs.sprintf(clickMe.availableCallbacks)
fs.sprintf(Object.getOwnPropertyNames(clickMe))

clickMe.buttonPress = function() {
  fs.sprintf(clickMe.getLabel())
  clickMe.setLabel(randomUUID4())
  fs.sprintf(clickMe.getLabel())

  if(clickMe.getHasFrame()) {
    clickMe.setHasFrame(false)
  } else {
    clickMe.setHasFrame(true)
  }
}

clickHim.buttonPress = function() {
  fs.sprintf(clickHim.getLabel())
  clickHim.setLabel(randomUUID4())
  fs.sprintf(clickHim.getLabel())
}

clickHer.buttonPress = function() {
  fs.sprintf(clickHer.getLabel())
  clickHer.setLabel(randomUUID4())
  fs.sprintf(clickHer.getLabel())
}

clickIt.buttonPress = function() {
  fs.sprintf(clickIt.getLabel())
  clickIt.setLabel(randomUUID4())
  fs.sprintf(clickIt.getLabel())
}
