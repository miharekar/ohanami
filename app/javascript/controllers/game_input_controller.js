import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.formTarget.querySelectorAll("input").forEach((element) => {
      element.addEventListener("input", (event) => {
        if (event.data === null) return

        this.formTarget.requestSubmit()
      })

      element.addEventListener("focus", (event) => {
        if (event.target.value !== "0") return

        event.target.value = ""
      })
    })
  }
}
