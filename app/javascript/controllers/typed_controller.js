import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
var options = {
  strings: ['Are you a book-lover ready to dive into a new book? ', 'Or a colectionist willing to generate an extra income?'],
  typeSpeed: 50,
  showCursor: false
};

 new Typed(this.element, options);

  }
}
