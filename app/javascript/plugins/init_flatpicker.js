import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
// import "flatpickr/dist/flatpickr.min.css";

const initFlatpickr = () => {

const flatpickrBooking = document.querySelector("#booking_end_date");
const flatpickrHomepage = document.querySelector("#search_end_date");

  if (flatpickrBooking) {
    flatpickr("#booking_start_date", {
      minDate: new Date(),
      "plugins": [new rangePlugin({ input: "#booking_end_date"})],
    });
  }
  if (flatpickrHomepage) {
    flatpickr("#search_start_date", {
        minDate: new Date(),
          "plugins": [new rangePlugin({ input: "#search_end_date"})],
    });
  }
}

export { initFlatpickr }
