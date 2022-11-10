import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
var options = {
  strings: ['Are you a book-lover ready to dive into a new book? ^1000',
            'Or a colectionist willing to generate an extra income? ^1000'],
  typeSpeed: 20,
  showCursor: false
};

 new Typed(this.element, options);

  }
}
