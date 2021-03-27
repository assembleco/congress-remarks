import React from 'react'

import { makeAutoObservable } from "mobx"

class Remark {
  place = ''
  body = ''
  person = {
    handle: null,
    badges: [],
  }

  constructor() {
    makeAutoObservable(this)
  }
}

export default Remark
