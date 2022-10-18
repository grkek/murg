import Component from "./example/dist/scripts/components/Component"

class Label extends Component {
  constructor(container, { content }) {
    super()

    this.eventListeners = { focusChange: () => { }, motionNotify: () => { } }

    let label = document.createElement(container, 'label')

    label.setLabel(content)

    label.focusChange = () => { this.eventListeners.focusChange() }
    label.motionNotify = () => { this.eventListeners.motionNotify() }

    this.id = label.id
    this.element = label
  }

  addEventListener(eventName, callbackFunction) {
    this.eventListeners[eventName] = callbackFunction
  }
}

export default Label