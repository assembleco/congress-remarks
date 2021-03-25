import React from 'react'
import { observer } from "mobx-react"

const Code = observer(({ source }) => (
  <div>Displaying {source && source.key}!</div>
))

export default Code
