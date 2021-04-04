import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

var Homepage = ({ children }) => (
  <Grid>
    {children}
    <p>
      <h2>H.R. 1: "For the People"</h2>
      Leave your remarks on House Resoultion # 1.
      <br/>Remind Congress – our laws should also
      <br/>be made <b>*by the people*</b>.

      <h4>Seeking Sponsorship</h4>
      Help us upgrade and change congressional bills
      <br/>by sourcing ideas and remarks on social media.
    </p>
  </Grid>
)

var Grid = styled.div`
display: grid;
grid-template-columns: auto 1fr;
grid-column-gap: 4rem;
font-family: "Ruluko";
`

export default Homepage
