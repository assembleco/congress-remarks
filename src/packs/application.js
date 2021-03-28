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

import { autorun, observable } from "mobx"
import { observer } from "mobx-react"

import Bill from "../bill"
import Remark from "../remark"
import Code from "../code"

var bill = new Bill()
autorun(() => console.log(bill.key))

var remarks = observable([])

fetch("/bills/117hr1eh")
  .then(response => response.json())
  .then(response => {
    bill.key = response.key
    bill.measure = response.source
  })

var pull_remarks = () =>
  fetch("/remarks")
    .then(response => response.json())
    .then(response => {
      remarks.replace(response.map(x => {
        var remark = new Remark()
        remark.place = x.place
        remark.body = x.body
        remark.person = x.person
        return remark
      }))
    })

var pull_session = () => fetch('/sessions', {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
      'Authorization': localStorage.getItem("code"),
    }})
    .then(response => response.json())
    .then(response => runInAction(() => person = response.person ))

pull_remarks()

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Code
    source={bill}
    remarks={remarks}
    pull_remarks={pull_remarks}
    />,
    document.body.appendChild(document.createElement('div')),
  )
})
