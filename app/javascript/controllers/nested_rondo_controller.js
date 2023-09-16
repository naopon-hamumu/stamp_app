import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fieldContain", "removeButton", "addButton"];

  connect() {
    this.updateRemoveButtonVisibility();
    this.updateAddButtonVisibility();
  }

  addField(e) {
    e.preventDefault();

    if (this.fieldContainTarget.children.length - 1 >= 7) {
      return;
    }

    let assoc = e.target.dataset.association;
    let newField = this.buildNewAssociation(assoc);
    this.fieldContainTarget.insertAdjacentHTML("beforeend", newField);

    const newMapContainer = this.fieldContainTarget.lastElementChild;
    window.initMap(newMapContainer);

    this.updateRemoveButtonVisibility();
    this.updateAddButtonVisibility();
  }

  removeField(e) {
    e.preventDefault();

    let wrapperClass = this.data.get("wrapperClass") || "nested-fields";
    let wrapperField = e.target.closest("." + wrapperClass);
    if(e.target.matches('.dynamic')) {
      wrapperField.remove();
    } else {
      wrapperField.querySelector("input[name*='_destroy']").value = 1;
      wrapperField.style.display = "none";
    }

    this.updateRemoveButtonVisibility();
    this.updateAddButtonVisibility();
  }

  buildNewAssociation(assoc) {
    let content  = this.templateTarget.innerHTML;
    let regexpBraced = new RegExp('\\[new_' + assoc + '\\]', 'g');
    let newId  = new Date().getTime();
    let newContent = content.replace(regexpBraced, '[' + newId + ']');

    if (newContent == content) {
      regexpBraced = new RegExp('\\[new_' + assoc + 's\\]', 'g');
      newContent = content.replace(regexpBraced, '[' + newId + ']');
    }
    return newContent;
  }

  updateRemoveButtonVisibility() {
    const numberOfFields = this.fieldContainTarget.children.length - 1;
    const removeButtons = this.removeButtonTargets;

    if (numberOfFields <= 1) {
      removeButtons.forEach(button => button.style.display = "none");
    } else {
      removeButtons.forEach(button => button.style.display = "inline-block");
    }
  }

  updateAddButtonVisibility() {
    if (this.fieldContainTarget.children.length - 1 >= 7) {
      this.addButtonTarget.style.display = "none";
    } else {
      this.addButtonTarget.style.display = "inline-block";
    }
  }
}
