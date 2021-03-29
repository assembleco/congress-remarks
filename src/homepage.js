import React from 'react'
import { observer } from "mobx-react"
import styled from "styled-components"

var Homepage = ({ children }) => (
  <Grid>
    <h1>"For the People" Act</h1>
    <span>Sponsorship...</span>
    {children}
  </Grid>
)

var Grid = styled.div`
display: grid;
grid-template-columns: auto 1fr;
grid-column-gap: 4rem;
`

export default Homepage
