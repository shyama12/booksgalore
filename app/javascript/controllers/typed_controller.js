import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
var options = {
  strings: ['books..', ' books, books....'],
  typeSpeed: 40,
  loop: true,
  showCursor: false
};

 new Typed(this.element, options);

  }
}
