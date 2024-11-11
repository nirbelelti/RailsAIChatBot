import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = [ "scroll" ]
  connect() {
    console.log("scroll connect")
    requestAnimationFrame(() => this.scrollToBottom());
  }

  update() {
    // Call this method when content changes, if needed
    this.scrollToBottom();
  }

  scrollToBottom() {
    console.log("scroll to bottom")
    this.element.scrollIntoView({ behavior: "smooth", block: "end" });
  }
}
