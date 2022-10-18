import Component from "./example/dist/scripts/components/Component"

class Entry extends Component {
  constructor(container) {
    super()

    this.eventListeners = { focusChange: () => { }, motionNotify: () => { }, keyPressed: (keyValue) => { } }

    let entry = document.createElement(container, 'entry')

    entry.focusChange = () => { this.eventListeners.focusChange() }
    entry.motionNotify = () => { this.eventListeners.motionNotify() }
    entry.keyPressed = (keyValue) => { this.eventListeners.keyPressed(keyValue) }

    this.id = entry.id
    this.element = entry
  }

  addEventListener(eventName, callbackFunction) {
    this.eventListeners[eventName] = callbackFunction
  }
}

export default Entry