import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "slide" ]
  static values = { count: Number }

  initialize() {
    this.index = 0
    this.showCurrentSlide()
    console.log(this.countValue)
    console.log(typeof this.countValue)
  }

  next() {
    if (this.index >= this.countValue - 1) {
      this.index = 0
      this.showCurrentSlide()
    }else{
      this.index++
      this.showCurrentSlide()
    }
  }

  previous() {
    if (this.index <= 0) {
      this.index = this.countValue - 1
      this.showCurrentSlide()
    }else{
      this.index--
      this.showCurrentSlide()
    }
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.index
    })
  }
}
