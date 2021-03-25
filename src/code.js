import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

const Code = observer(({ source }) => (
  <div>
    <h1>{source.key}</h1>
    <Measure {...source.measure} />
  </div>
))

var Measure = observer(({ marker, label, heading, source, submeasures }) => {
  var body = source || ''

  var matches = body.matchAll(/\{place +\"([A-H0-9]+)\"\}/g)

  var children = []
  var index = 0
  var code = matches.next()
  while(!code.done) {
    children.push(body.slice(index, code.value.index))
    index = code.value.index

    var measure = submeasures.filter(x => x.key == code.value[1])[0]
    children.push(<Measure {...measure} />)
    index += code.value[0].length

    code = matches.next()
  }
  children.push(body.slice(index))

  return (
    <Borderline>
      <h2>{label}: {heading}</h2>
      {children}
    </Borderline>
  )
})

var Borderline = styled.pre`
border-left: 4px solid grey;
padding-left: 12px;
`

export default Code
