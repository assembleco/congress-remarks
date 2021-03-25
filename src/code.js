import React from 'react'
import { observer } from "mobx-react"

const Code = observer(({ source }) => (
  <div>
    <h1>{source.key}</h1>
    <Measure {...source.measure} />
  </div>
))

var Measure = observer(({ marker, label, heading, source, submeasures }) => {
  var body = source

  if(body)
    body = body.replaceAll(/(\{place +\"([A-H0-9]+)\"\})/g, (a, b, c, d, e) => {
      return submeasures.filter(x => x.key == c)[0].source
    })

  return (
    <div>
      <h2>{label}: {heading}</h2>
      <pre>{body}</pre>
    </div>
  )
})

export default Code
