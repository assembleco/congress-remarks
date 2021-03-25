import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

const Code = observer(({ source }) => (
  <Page>
    <h1>{source.key}</h1>
    <Measure {...source.measure} level={0} />
  </Page>
))

var Measure = observer(({ marker, label, heading, source, submeasures, level }) => {
  var body = source || ''

  var matches = body.matchAll(/\{place +\"([A-H0-9]+)\"\}/g)

  var children = []
  var index = 0
  var code = matches.next()
  while(!code.done) {
    children.push(body.slice(index, code.value.index).trim())
    index = code.value.index

    var measure = submeasures.filter(x => x.key == code.value[1])[0]
    children.push(<Measure {...measure} level={level + 1} />)
    index += code.value[0].length

    code = matches.next()
  }
  children.push(body.slice(index))

  return (
    <Borderline level={level} >
      <Heading>{label}: {heading}</Heading>
      {children}
    </Borderline>
  )
})

var Heading = styled.h3`
margin: 0.2rem;
display: inline-block;
`

var Page = styled.div`
background: bisque;
border: 4px solid grey;
width: 60rem;
overflow-x: hidden;
`

var Borderline = styled.div`
margin: 4px;
padding-left: 8px;
white-space: pre-wrap;
border-left: 4px solid ${({ level }) => (
[
"#b58900",
"#cb4b16",
"#dc322f",
"#d33682",
"#6c71c4",
"#268bd2",
"#2aa198",
"#859900",
][level] || 'grey'
)};
`

export default Code
