import React from "react"
import { observer } from "mobx-react"
import styled from "styled-components"
import { observable, autorun, toJS, runInAction } from "mobx"

const SessionField = styled.input`
background: none;
border: none;
border-bottom: 2px solid black;
`

const session = observable({
  email: null,
  handle: null,
  pending: false,
  person: null,
})

session.pull = () => fetch('/sessions', {
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
    'Authorization': localStorage.getItem("code"),
  }})
  .then(response => response.json())
  .then(response => runInAction(() => session.person = response.person ))

session.pull()

const Session = () => {
  if(!session.person) {
    return (
      session.pending
      ? <Paragraph>
          Please check your email,
          <br/>
          or&nbsp;
          <Link href="#"
            onClick={() => runInAction(() => {
              session.email = null
              session.handle = null
              session.pending = false
              session.person = null
            })}
          >sign in again</Link>.
        </Paragraph>
      :
        <Area>
          <h4>Sign in and place your remarks.</h4>
          <Query
            type="text"
            placeholder="handle (public)"
            onChange={(e) => runInAction(() => session.handle = e.target.value)}
            value={session.handle || ""}
          />
          <Query
            type="email"
            placeholder="email"
            onChange={(e) => runInAction(() => session.email = e.target.value)}
            value={session.email || ""}
          />
          <SignIn onClick={(e) => { e.preventDefault(); signIn()}} >
            Sign in
          </SignIn>
        </Area>
    )
  }

  return (
    <Paragraph>
      Signed in as {session.person.handle}.
      <br/>
      <Link
      href="#"
      onClick={() => {
        runInAction(() => {
          session.email = null
          session.handle = null
          session.pending = false
          session.person = null
        });
        localStorage.removeItem("code")
      }}>end session.</Link>
    </Paragraph>
  )
}

const signIn = () => {
  runInAction(() => session.pending = true)
  fetch("/sessions", {
    method: "POST",
    body: JSON.stringify({
      person: {
        email: session.email,
        handle: session.handle,
      },
    }),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
    },
  })
  .then(response => response.json())
  .then(response => console.log(response))
}

const Area = styled.div`
display: flex;
flex-direction: column;
`

const Query = styled.input`
font-size: 16px;
line-height: 24px;
&::placeholder {
  color: #a0a0a0;
}
color: #a0a0a0;
padding: 0.4rem;
background-color: rgba(212, 196, 196, 0.2);
border: none;
margin-bottom: 0.2rem;
outline: none;
`

const SignIn = styled.button`
width: 100%;
padding: 0.5rem;
background-color: rgba(196, 196, 212, 0.6);
border-radius: 4px;
outline: none;
border: none;
`

const Link = styled.a`
color: rgb(196, 196, 216);
`

const Paragraph = styled.p`
`

export { session }
export default observer(Session)
