// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import React from 'react'
import ReactDOM from 'react-dom'

import { autorun } from "mobx"
import { observer } from "mobx-react"

import Bill from "../bill"
import Code from "../code"

var bill = new Bill()
autorun(() => console.log(bill.key))

fetch("/bills/117hr1eh")
  .then(response => response.json())
  .then(response => bill.key = response.key)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Code source={bill} />,
    document.body.appendChild(document.createElement('div')),
  )
})