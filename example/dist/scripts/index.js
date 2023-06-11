// Create a button with a "Hello, World!" text in the middle.

let button = std.element.button.createLabel(std.element.getElementById("mainWindow"), "Hello, World!");

button.properties.onPress = function() {
  button.setLabel(std.minuscule.uuid());
}

console.log(button)