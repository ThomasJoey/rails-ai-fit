import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sportItem", "filterInput"]

  connect() {
    this.filterSports()
  }

  filter(event) {
    this.filterSports()
  }

  filterSports() {
    const selectedFilter = this.filterInputTargets.find(input => input.checked)?.value || "all"
    
    this.sportItemTargets.forEach(item => {
      const category = item.dataset.category
      
      if (selectedFilter === "all" || category === selectedFilter) {
        item.style.display = "block"
      } else {
        item.style.display = "none"
      }
    })
  }
}