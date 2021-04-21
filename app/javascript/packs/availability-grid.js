// generating main table rows: header + hours (0~23)
const availabilityBox = document.getElementById('js-grid');
function generateTableRows(parent) {
  for (let i=-1; i<=23; i++) {
    const row = document.createElement('div');
    parent.appendChild(row);
    row.id = 'row' + i;
    row.className = 'row';
  }
};
generateTableRows(availabilityBox);

// generating table's column headers
const rowHeader = document.getElementById('row-1');
const week = ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
function generateColumnHeaders(row) {
  for (let i=0; i<=7; i++) {
    const header = document.createElement('div');
    row.appendChild(header);
    header.innerHTML = week[i];
    header.className = 'columnHeader';
  }
}
generateColumnHeaders(rowHeader);

// generating availability grid
function generateAvailability(row) {
  let rowIndex = 0;
  for (let i=0; i<=7; i++) {
    const availabilityBox = document.createElement('div');
    row.appendChild(availabilityBox);
    if (i === 0) {
      availabilityBox.innerHTML = rowIndex;
      availabilityBox.className = 'rowHeader';
      //availabilityBox.id = params-attributes
      rowIndex += 1;
    } else {
      availabilityBox.className = 'availabilityBox';
    }
  }
};

const rows = document.getElementsByClassName('row');
[...rows].forEach(row => {
  console.log(row);
  // if (row !== 'row-1') {
  // }
})

