import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="likes"
export default class extends Controller {
  static targets = ['count', 'article']

  connect() {
  }

  increment(_e) {
    let el = this.countTarget
    let id = this.articleTarget.dataset.id

    fetch(`/articles/${id}/like`, {
      method: 'PATCH',
      headers: {
        'Content-Type':'application/json',
        'X-CSRF-Token': this.csrfToken()
      }
    })
      .then(r => r.json())
      .then(json => el.innerText = json.likes)
      .catch(console.log)
  }

  csrfToken() {
    return document.querySelector('meta[name=csrf-token]').content
  }
}
