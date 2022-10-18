import Component from "./example/dist/scripts/components/Component"

class Button extends Component {
  constructor(container, { content }) {
    super()

    this.eventListeners = { focusChange: () => { }, motionNotify: () => { }, buttonPress: () => { } }

    let button = document.createElement(container, 'button')

    button.setLabel(content)

    button.focusChange = () => { this.eventListeners.focusChange() }
    button.motionNotify = () => { this.eventListeners.motionNotify() }
    button.buttonPress = () => { this.eventListeners.buttonPress() }

    this.id = button.id
    this.element = button
  }

  addEventListener(eventName, callbackFunction) {
    this.eventListeners[eventName] = callbackFunction
  }
}

export default Button