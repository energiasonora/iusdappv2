# IUS DAPP

Ius Naturalis is a project centered on digital sovereignty, addressing key areas such as value creation and transfer, communication, document management, and the resolution of public and private disputes—all approached from a sovereign perspective under natural law jurisdiction.
We are developing a self-custodial wallet that integrates chat and public document management capabilities, including attestation and dispute resolution mechanisms.
Our goal is to foster a web3 culture rooted in sovereignty, promoting the adoption of customary practices for managing public goods and embracing decentralized solutions in governance.


# DEMO
https://iusnaturalis.web.app/

# GIT REPO
git https://github.com/energiasonora/iusdappv2

# OTHER LINKS

polybase zk db: https://testnet.polybase.xyz/v0/collections/Collection/records/pk%2F0x97eab0841786aeae14135af5e26750626e46e2e15a412b6a319dd2ce7f323c805d67fcfb0f8ea1f27959e486e11e49926fbf4b1c2b9252daa20283e200e3b1b3%2FSTARKID%2FSTARKID


xmtp chat docs https://docs.xmtp.org/get-started/developer-quickstart

xmtp docs: https://docs.xmtp.org/perf-ux/optimistic-sending

xmtp v3 https://docs.xmtp.org/upgrade-to-v3

gitcoin grants g22: https://grants.gitcoin.co/?utm_source=gitcoinco&utm_medium=nav&utm_campaign=v2


demo local: https://192.168.1.52localhost:4343/

encrypted chat:
alice https://192.168.1.52:4343/p2pAlice.html
bob https://192.168.1.52:4343/p2pBob.html

xmtp status https://status.xmtp.com/


polybase db git https://github.com/polybase/polybase-db-docs

ethhack 
https://ethglobal.com/showcase/iuris-naturalis-bofn4

# INSTALL
```
nvm use 20
yarn                              
```

# RUN
```
yarn parcel src/index.html  --port 4343 --https
```
<!-- 
yarn parcel src/index.html  src/stealthG.html src/p2pAlice.html  src/p2pBob.html --port 4343 --https
  -->

# deploy to firebase

```
rm -rf .parcel-cache
nvm use 20
yarn parcel src/index.html --dist-dir public  --public-url ./
yarn parcel src/index.html src/crowdfunding.html  --dist-dir public  --public-url ./
firebase deploy --only hosting:iusnaturalis
```


# CONTRACTS
<!-- testnet v5 0x70F0B5fa20C296703fe101f294913cd1B6cCE053 -->

# log
- 5.15
* fix removeTokens funcitonality(wip)
* improved load time with base64imgs and localstorage defaults
- v5.14 
* improved loading time by loading tokens and address from localstorage.
* added preloader for chat history
* minimal send button for simple external txs
- v5.13 fixed qrScanner inversion mode.
- v5.12 ui fixes, wallet button reposition
- v5.11a pufix balances display
- v5.11 public
- v5.10 new wallet modal adn ux fixes
* v5.09 ::: bug: no muestra el cambio a token (x ej usdc) cuando se selecciona un EVM
* v5.08 new wallet stats(brouillon), status buton, bugsFix: multiples duplicated messages, 
- v5.07 manage stealth addrs funds
- v5.07a fix chainsv1.json
- v5.06 send native and erc20 stealth addrs txs
- v5.05 stealthaddr fixes(in progress). save contacts into did
- v5.04 display public docs
- v5.03 change alias name
- v5.02 fixed upload to ipfs
- v5.01 lighthouse as ipfs provider
- v4.13 fix autopopulate erc20
- v4.12 fix unlock screen
- v4.11 avatar img fix
- v4.10 qr scan fix
- v4.09 chatUI fix. step with 0 decimal tokens. wiki links
- v4.08 wallet. add tokens. send/receibe
- v4.07 fixing agenda management. fixed newmessage stucked class. fixing bug deletes username
- v4.06 fixed scan and chat did bug
- v4.05 fix restore seed
- v4.04 improved mnemonic backup process
- v4.03 check contract and address balance in explorer
- v4.0 improved DID management
- v3.4 https://youtu.be/p4xMzkIS5wQ
- fixed ui bugs. when clicking oiutside navbar should close the navbar when comming fron t2addr (external) link 
- preparing UI to broadcast signatures functionality
- contacts: add functionality for states(trust:green, block:red, none:white)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

### Summary of GPLv3:
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).
