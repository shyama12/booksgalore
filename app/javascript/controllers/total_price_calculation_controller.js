import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price-calculation"
export default class extends Controller {
  static targets = ["start", "end", "total", "ppd"];

  connect() {
  }

  calcPrice() {
    const start_day = this.startTarget.querySelector("#booking_start_date_3i").value;
    const start_month = this.startTarget.querySelector("#booking_start_date_2i").value;
    const start_year = this.startTarget.querySelector("#booking_start_date_1i").value;
    const start_date = new Date(Number.parseInt(start_year, 10), Number.parseInt(start_month, 10) - 1, Number.parseInt(start_day, 10))

    const end_day = this.endTarget.querySelector("#booking_end_date_3i").value;
    const end_month = this.endTarget.querySelector("#booking_end_date_2i").value;
    const end_year = this.endTarget.querySelector("#booking_end_date_1i").value;
    const end_date = new Date(Number.parseInt(end_year), Number.parseInt(end_month) - 1, Number.parseInt(end_day));
    if(end_date.getTime() > start_date.getTime()) {
      let time_difference = end_date.getTime() - start_date.getTime();
      time_difference /= 1000*60*60*24;

      const ppd = Number(this.ppdTarget.getAttribute("value"), 10);
      this.totalTarget.innerText = `Total price: £${(time_difference * ppd).toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}`;
    }else {
      this.totalTarget.innerText = `End date should be a date after start date`;
    }
  }
}
