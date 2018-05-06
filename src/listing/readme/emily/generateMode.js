import Emily, { generateMode } from 'emily-editor'
// ...

ReactDOM.render(
  <Emily language={generateMode(/*...*/)} />,
  document.getElementById('container')
);