import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
    console.log("working connection from Controller")

var options = {
  strings: ['books..', ' books, books....'],
  typeSpeed: 40
};

 new Typed(this.element, options);

  }
}
