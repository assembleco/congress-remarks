import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

const Code = observer(({ source }) => (
  <Page>
    <h1>{source.key}</h1>
    <Measure {...source.measure} level={0} />
  </Page>
))

var Measure = observer(({ marker, label, heading, source, submeasures, level, box }) => {
  var body = source || ''

  var matches = body.matchAll(/\{place +\"([A-H0-9]+)\"\}/g)

  var children = []
  var index = 0
  var code = matches.next()
  while(!code.done) {
    children.push(body.slice(index, code.value.index).trim())
    index = code.value.index

    var measure = submeasures.filter(x => x.key == code.value[1])[0]
    children.push(
      <Measure
      {...measure}
      level={measure.marker === "quoted-block" ? 0 : level + 1}
      box={measure.marker === "quoted-block"}
      />
    )
    index += code.value[0].length

    code = matches.next()
  }
  children.push(body.slice(index))

  return (
    <Borderline box={box} level={level} >
      <Heading>{label}: {heading}</Heading>
      <Body>{children}</Body>
    </Borderline>
  )
})

var Heading = styled.h3`
margin: 0.2rem;
margin-bottom: 0;
display: inline-block;
font-family: "Times";
`

var Body = styled.div`
display: inline;
font-family: "Ruluko";
`

var Page = styled.div`
background: #faf9dd;
border: 4px solid #3d3b11;
color: #3d3b11;
width: 48rem;
overflow-x: hidden;
padding-left: 12px;
padding-right: 16px;
`

var Borderline = styled.div`
margin: 4px;
margin-right: 0;
padding-left: 8px;
white-space: pre-wrap;
border-left: 4px solid ${({ level }) => (
[ "#b58900", "#cb4b16", "#dc322f", "#d33682", "#6c71c4", "#268bd2", "#2aa198", "#859900", ][level] || 'grey'
)};
${({ box }) => box && `
  background: #d4f1d9aa;
  padding: 8px;
`}
`

export default Code
