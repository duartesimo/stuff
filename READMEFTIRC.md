*This project has been created as part of the 42 curriculum by nsimao-f, tialbert.*

# ft_irc

## Description

`ft_irc` is a small IRC server written in **C++98**.

The goal of the project is to implement the core behavior of an IRC server that can:
- accept multiple simultaneous client connections
- authenticate users with a password
- let users choose a nickname and username
- let users join channels
- support private and channel messages
- support channel operators and the required channel modes

This project does **not** implement:
- an IRC client
- server-to-server communication

The server is built around a single non-blocking `poll()` event loop and was tested with **Irssi** as the reference IRC client.

## Features

### Mandatory features
- password-based connection
- nickname and username registration
- channel join / part
- private messages
- channel messages
- operators and regular users
- operator commands:
  - `KICK`
  - `INVITE`
  - `TOPIC`
  - `MODE`

### Implemented channel modes
- `i` — invite-only channel
- `t` — only operators may change the topic
- `k` — channel key/password
- `o` — give/take operator privileges
- `l` — user limit

## Instructions

### Build

```bash
make
```

### Run

```bash
./ircserv <port> <password>
```

Example:

```bash
./ircserv 6667 mypass
```

### Reference client

The reference IRC client used for this project is:

- **Irssi**

Example connection:

```text
/connect 127.0.0.1 6667 mypass bob
```

### Basic usage example

After connecting with Irssi:

```text
/join #test
/msg #test hello everyone
/topic #test new topic
/mode #test +i
```

### Project structure

- `include/` — headers
- `src/net/` — listener, poller, connection, buffer
- `src/irc/` — server logic, client/channel helpers
- `src/commands/` — IRC command handlers

## Technical overview

The project is split into two main layers:

### 1. Core infrastructure
This handles:
- sockets
- listener setup
- non-blocking I/O
- `poll()`
- buffering
- IRC line parsing
- command dispatch

### 2. IRC command layer
This handles:
- registration
- channel membership
- messaging
- operator permissions
- channel modes
- numeric replies

The server receives bytes from sockets, rebuilds complete IRC lines, parses them into structured messages, dispatches the correct command handler, and queues outgoing replies for later non-blocking sends.

## Testing

The server was mainly tested with:
- **Irssi**
- `nc -C`

Typical tests included:
- registration (`PASS`, `NICK`, `USER`)
- partial command reconstruction
- multiple simultaneous clients
- channel messaging
- operator-only commands
- channel modes
- stopped client (`Ctrl+Z`) and resumed client (`fg`) behavior

## Resources

### IRC / networking references
- IRC protocol overview
- Irssi documentation
- `poll(2)`, `socket(2)`, `accept(2)`, `recv(2)`, `send(2)`, `fcntl(2)` man pages

### AI usage

AI was used as a support tool during the project for:
- discussing architecture choices
- reviewing code organization
- improving documentation
- preparing testing checklists

AI was **not** used as a blind copy-paste source. All generated ideas and code suggestions were reviewed, adapted, tested, and manually understood before being kept in the project.
