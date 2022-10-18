import Component from "./example/dist/scripts/components/Component"

class Box extends Component {
  constructor(container) {
    super()

    this.eventListeners = { focusChange: () => { }, motionNotify: () => { } }

    let box = document.createElement(container, 'box')

    box.focusChange = () => { this.eventListeners.focusChange() }
    box.motionNotify = () => { this.eventListeners.motionNotify() }

    this.id = box.id
    this.element = box
  }

  addEventListener(eventName, callbackFunction) {
    this.eventListeners[eventName] = callbackFunction
  }
}

export default Box