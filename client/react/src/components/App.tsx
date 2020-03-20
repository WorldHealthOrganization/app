import React from 'react';
import logo from '../assets/logo.svg';
import './App.css';
import {S} from "../i18n/S";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <a
          className="App-link"
          href="https://who.int"
          target="_blank"
          rel="noopener noreferrer"
        >
          {S.worldHealthOrganization}
        </a>
      </header>
    </div>
  );
}

export default App;
