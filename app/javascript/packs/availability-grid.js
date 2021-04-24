// generating main table rows: header + hours (0~23)
const availabilityBox = document.getElementById('js-grid');
function generateTableRows(parent) {
  for (let i=-1; i<=23; i++) {
    const row = document.createElement('div');
    parent.appendChild(row);
    row.id = 'row' + i;
    row.className = 'availabilityRow';
  }
};
generateTableRows(availabilityBox);

// generating table's column headers
const rowHeader = document.getElementById('row-1');
const week = ['', 'M', 'T', 'W', 'T', 'F', 'S', 'S'];
function generateColumnHeaders(row) {
  for (let i=0; i<=7; i++) {
    const header = document.createElement('div');
    row.appendChild(header);
    header.innerHTML = week[i];
    header.className = 'columnHeader box';
  }
}
generateColumnHeaders(rowHeader);

// generating availability grid
const paramsArray = ['', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
let rowIndex = 0;
function generateAvailability(row) {
  for (let i=0; i<=7; i++) {
    const availabilityBox = document.createElement('div');
    const innerSquare = document.createElement('div');
    row.appendChild(availabilityBox);
    if (i === 0) {
      availabilityBox.innerHTML = rowIndex;
      availabilityBox.className = 'rowHeader box';
      rowIndex += 1;
    } else {
      availabilityBox.className = 'availabilityBox box';
      availabilityBox.appendChild(innerSquare);
      innerSquare.className = 'square';
      // setting availability box data-params attribute = to registrations controller params
      innerSquare.setAttribute('data-params', `availability_options_${paramsArray[i]}-${(rowIndex - 1)}`);
    }
  }
};

const rows = document.getElementsByClassName('availabilityRow');
const rowsArray = [...rows];
rowsArray.shift();
rowsArray.forEach(row => generateAvailability(row));

// adding event listener to toggle availability boxes status and connecting them to original params checkboxes
const box = document.getElementsByClassName('square');
let isMouseDown = false;
[...box].forEach(box => {
  box.addEventListener('mouseover', e => {
    if (isMouseDown) {
      e.target.classList.toggle('available');
      const datasetParams = e.target.dataset.params;
      const paramsCheckbox = document.getElementById(datasetParams);
      if (e.target.classList.contains('available')) {
        paramsCheckbox.previousSibling.value = 1;
      } else {
        paramsCheckbox.previousSibling.value = 0;
      }
    }
    box.addEventListener('mousedown', e => {
      isMouseDown = true;
    })
  });

  box.addEventListener('click', e => {
    e.target.classList.toggle('available');
    const datasetParams = e.target.dataset.params;
    const paramsCheckbox = document.getElementById(datasetParams);
    if (e.target.classList.contains('available')) {
      paramsCheckbox.previousSibling.value = 1;
    } else {
      paramsCheckbox.previousSibling.value = 0;
    }
  })
});

window.addEventListener('mouseup', e => {
  isMouseDown = false;
});


