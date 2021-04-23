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
let rowIndex = 0;
function generateAvailability(row) {
  for (let i=0; i<=7; i++) {
    const availabilityBox = document.createElement('div');
    const innerSquare = document.createElement('div');
    row.appendChild(availabilityBox);
    if (i === 0) {
      availabilityBox.innerHTML = rowIndex;
      availabilityBox.className = 'rowHeader box';
      //availabilityBox.id = params-attributes
      rowIndex += 1;
    } else {
      availabilityBox.className = 'availabilityBox box';
      availabilityBox.appendChild(innerSquare);
      innerSquare.className = 'square';
    }
  }
};

const rows = document.getElementsByClassName('availabilityRow');
const rowsArray = [...rows];
rowsArray.shift();
rowsArray.forEach(row => generateAvailability(row));

const box = document.getElementsByClassName('availabilityBox');
[...box].forEach(box => {
  box.addEventListener('mousedown', e => {
    e.target.classList.toggle('available');
  } )
});
