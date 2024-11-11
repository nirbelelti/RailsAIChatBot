import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question-submit"
export default class extends Controller {
    static targets = [ "button", "spinner","input" ]

  connect() {
    console.log("connect")
  }
  submitStart() {
      this.buttonTarget.disabled = true
      this.spinnerTarget.classList.remove("d-none");
    }

    submitEnd() {
        this.buttonTarget.disabled = false
        this.spinnerTarget.classList.add("d-none");
        this.inputTarget.value = ""
    }
}
