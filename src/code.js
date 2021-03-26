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
    remark: null,
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
        remarking={this.state.remark !== null}
        box={box}
        level={level}
        onClick={(e) => {
          this.setState({ collapsed: !this.state.collapsed })
          e.stopPropagation()
        }}
      >
        <RemarkBalloon
          remarking={this.state.remark !== null}
          onClick={(e) => {
            this.setState({ remark: '' })
            e.stopPropagation()
          }}
        >
          {this.state.remark === null
          ?
            <Icon
              icon={commentIcon}
              rotate="90deg"
              flip="horizontal"
              color="#3d3b11"
              width="2rem"
              />
          :
            <RemarkGrid>
              <RemarkBox
              value={this.state.remark}
              ref={(node) => node && node.focus()}
              onChange={(e) => {
                this.setState({ remark: e.target.value })
              }} />
              <Clickable onClick={() => this.setState({ remark: null })}>
                Cancel
              </Clickable>
              <Clickable
                color="#86de86"
                onClick={() => null}
              >
                Place Remark
              </Clickable>
            </RemarkGrid>
          }
        </RemarkBalloon>

        <Heading>{label}: {heading}</Heading>
        {!this.state.collapsed && <Body>{children}</Body>}
      </Borderline>
    )
  }
}

var RemarkBalloon = styled.span`
position: absolute;
right: ${({remarking}) => remarking ? "-27rem" : "-3.2rem"};
top: 0;

&:hover svg path {
  stroke: #86de86;
}
`

var RemarkBox = styled.textarea`
height: 6rem;
width: 24rem;
padding: 0.6rem;
`

var Clickable = styled.button`
padding: 8px;
${({ color }) => color && `background-color: ${color};`}
color: #3d3b11;
outline: none;
border: 4px solid #3d3b11;
border-radius: 8px;
`

var RemarkGrid = styled.div`
display: grid;
grid-template-columns: auto 1fr;
grid-template-rows: 1fr auto;
grid-gap: 8px;

${RemarkBox} {
grid-column: 1 / -1;
}
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
border: 4px solid #3d3b11;
border-radius: 8px;
position: relative;
background: #faf9dd;
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

& > ${RemarkBalloon} {
  opacity: ${({remarking}) => remarking ? "100%" : 0};
  transition: opacity 0.2s ease-in;
}
&:hover > ${RemarkBalloon} {
  opacity: 100%;
}
`

export default Code
