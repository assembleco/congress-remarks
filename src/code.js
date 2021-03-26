import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

import { Icon, InlineIcon } from '@iconify/react'
import commentIcon from '@iconify-icons/akar-icons/comment'

const Code = observer(({ source }) => (
  <Page>
    <h1>{source.key}</h1>
    <Measure {...source.measure} level={0} />
  </Page>
))

@observer
class Measure extends React.Component {
  state = {
    collapsed: false,
  }

  render = () => {
    var { marker, label, heading, source, submeasures, level, box } = this.props
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
      <Borderline
      box={box}
      level={level}
      onClick={(e) => {
        this.setState({ collapsed: !this.state.collapsed })
        e.stopPropagation()
      }}
      >
        <RemarkBalloon>
          <Icon
            icon={commentIcon}
            rotate="90deg"
            flip="horizontal"
            color="#3d3b11"
            width="2rem"
          />
        </RemarkBalloon>

        <Heading>{label}: {heading}</Heading>
        {!this.state.collapsed && <Body>{children}</Body>}
      </Borderline>
    )
  }
}

var RemarkBalloon = styled.span`
position: absolute;
right: -3.2rem;
top: 0;
`

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
position: relative;
background: #faf9dd;
border: 4px solid #3d3b11;
color: #3d3b11;
width: 48rem;
padding-left: 12px;
padding-right: 16px;
`

var Borderline = styled.div`
position: relative;
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

${RemarkBalloon} {
  opacity: 0;
  transition: opacity 0.2s ease-in;
}
&:hover > ${RemarkBalloon} {
  opacity: 100%;
}
`

export default Code
