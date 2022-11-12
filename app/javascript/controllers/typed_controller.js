import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
var options = {
  strings: ['"You are not done with a book until you pass it to another reader." - Donalyn Miller ^1000'],
  typeSpeed: 20,
  showCursor: false
};

 new Typed(this.element, options);

  }
}
