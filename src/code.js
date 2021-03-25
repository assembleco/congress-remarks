import React from 'react'
import { observer } from "mobx-react"

const Code = observer(({ source }) => (
  <div>
    <h1>{source.key}</h1>
    <div>
      <h2>{source.measure.label}: {source.measure.heading}</h2>
      <p>{source.measure.source}</p>
    </div>
  </div>

))

export default Code
