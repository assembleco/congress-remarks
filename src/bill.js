import React from 'react'

import { makeAutoObservable } from "mobx"

class Bill {
  key = ''

  constructor() {
    makeAutoObservable(this)
  }
}

export default Bill
