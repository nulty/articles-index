import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="likes"
export default class extends Controller {
  static targets = [ 'count' ]
  connect() {
  }

  increment(_e) {
    let el = this.countTarget
    let count = parseInt(el.innerText)
    count++

    el.innerText = count
  }
}
