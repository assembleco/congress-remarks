import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

var Homepage = ({ children }) => (
  <Grid>
    <h1>"For the People" Act</h1>
    <p>
      Leave your remarks on House Resoultion # 1,
      <br/>the "For the People" act.
      <br/>Remind Congress – our laws should also
      <br/>be made <b>*by the people*</b>.

      <h4>Seeking Sponsorship</h4>
      Help us upgrade and change congressional bills
      <br/>using a social media-based approach.
    </p>
    {children}
  </Grid>
)

var Grid = styled.div`
display: grid;
grid-template-columns: auto 1fr;
grid-column-gap: 4rem;
font-family: "Ruluko";
`

export default Homepage
