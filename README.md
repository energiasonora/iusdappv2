# IUS DAPP

a sovereign decentralized platform (SDP) for peer to peer  public and private communication.

# LINKS
demo https://iusnaturalis.web.app
git https://github.com/energiasonora/iusdappv2


# INSTALL
```
nvm use 20
yarn                              
```

# RUN
```
yarn parcel src/index.html  --port 4343 --https
```
 

# deploy to firebase

```
nvm use 20
yarn parcel src/index.html --dist-dir public  --public-url ./
firebase deploy --only hosting:iusnaturalis
```


# CONTRACTS
<!-- testnet v5 0x70F0B5fa20C296703fe101f294913cd1B6cCE053 -->

# log
v4.12 fix unlock screen
v4.11 avatar img fix
v4.10 qr scan fix
v4.09 chatUI fix. step with 0 decimal tokens. wiki links
v4.08 wallet. add tokens. send/receibe
v4.07 fixing agenda management. fixed newmessage stucked class. fixing bug deletes username
v4.06 fixed scan and chat did bug
v4.05 fix restore seed
v4.04 improved mnemonic backup process
v4.03 check contract and address balance in explorer
v4.0 improved DID management
v3.4 https://youtu.be/p4xMzkIS5wQ
- fixed ui bugs. when clicking oiutside navbar should close the navbar when comming fron t2addr (external) link 
- preparing UI to broadcast signatures functionality
- contacts: add functionality for states(trust:green, block:red, none:white)
