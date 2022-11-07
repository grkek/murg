import Box from "./example/dist/scripts/components/Box"
import Button from "./example/dist/scripts/components/Button"
import Entry from "./example/dist/scripts/components/Entry"
import Label from "./example/dist/scripts/components/Label"

let box = new Box(mainWindow)
let button1 = new Button(box, { content: "Hello, World!" })
let button2 = new Button(box, { content: "Bye, World!" })
let entry = new Entry(box)
let label = new Label(box, { content: "I will change when you click the `Hello, World!` button" })

button1.addEventListener('buttonPress', () => {
  fs.sprintf("Hello, World!")

  label.element.setLabel(random.uuid())
})

button2.addEventListener('buttonPress', () => {
  fs.sprintf("Bye, World!")
})

fs.sprintf(Object.getOwnPropertyNames(entry.element))
fs.sprintf(Object.getOwnPropertyNames(button1.element))
