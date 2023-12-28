import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-form-submitter"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.formTarget.querySelectorAll("input").forEach((element) => {
      element.addEventListener("input", (event) => {
        if (event.data === null) return

        this.formTarget.requestSubmit()
      })
    })
  }
}
