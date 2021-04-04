import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

var Homepage = ({ children }) => (
  <Grid>
    {children}

    <Bylines>
      <h2>H.R. 1: "For the People"</h2>
      <p>
        Leave your remarks on House Resoultion # 1.
        <br/>Remind Congress – our laws should also
        <br/>be made <b>*by the people*</b>.
      </p>

      <h4>Seeking Sponsorship</h4>
      <p>
        Help us upgrade and change congressional bills
        <br/>by sourcing ideas and remarks on social media.
        <br/>
        <Press>
          Please see <a href="https://assembled.app">assembled.app</a>, online.
        </Press>
      </p>
    </Bylines>
  </Grid>
)

var Bylines = styled.div`
`

var Grid = styled.div`
display: grid;
grid-template-columns: auto 1fr;
grid-column-gap: 4rem;
font-family: "Ruluko";

@media print {
  grid-template-columns: 1fr;
  ${Bylines} {
    grid-row: 1;
  }
}
`

var Press = styled.span`
display: none;

@media print {
  display: inline;
}
`

export default Homepage
