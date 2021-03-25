import React from 'react'
import { observer } from "mobx-react"

const Code = observer(({ source }) => (
  <div>
    <h1>{source.key}</h1>
    <Measure {...source.measure} />
  </div>
))

var Measure = observer(({marker, label, heading, key, source, submeasures}) => (
    <div>
      <h2>{label}: {heading}</h2>
      <pre>{source}</pre>
    </div>
))

export default Code
