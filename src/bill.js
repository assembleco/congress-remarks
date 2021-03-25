import React from 'react'

import { makeAutoObservable } from "mobx"

class Bill {
  key = ''
  measure = {}

  constructor() {
    makeAutoObservable(this)
  }
}

export default Bill
