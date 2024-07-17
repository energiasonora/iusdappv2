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
v3.4
-fixed ui bugs. when clicking oiutside navbar should close the navbar when comming fron t2addr (external) link 
- preparing UI to broadcast signatures functionality
- contacts: add functionality for states(trust:green, block:red, none:white)