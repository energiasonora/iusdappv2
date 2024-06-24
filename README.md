# STARKID

a DID managing tool to communicate your public and private data with sovereignty


# LINKS
demo https://starkid.web.app

git https://github.com/xunorus/starkid


# INSTALL
<!-- nvm use 18     -->
```
nvm use 20
yarn                              
```

# RUN
```
yarn parcel src/index.html  --port 4444 --https
```
<!-- yarn parcel src/index.html src/connect.html  --port 4444 --https -->
<!-- yarn parcel src/index.html src/p2pencrypt.html  src/encryptv5.html  src/encryptv4b.html  src/argent.html src/encryptChat.html src/argentgen.html --port 4444 --https -->


# deploy to firebase

<!-- nvm use 18        -->
```
nvm use 20
yarn parcel src/index.html --dist-dir public  --public-url ./
firebase deploy --only hosting:starkid
```

# log
v0.14 gix storing contacts
v0.13 fix did record
v0.12 fix qr link and did calls
v0.11 url fixes
v0.10 bug fixes
v0.9 working chat!
v0.8 starkid console and xmtp server, agenda
v0.7 fixed priv encypt/decrypt for storage
v0.6 chat UI updates
v0.5 chat UI
v0.4 qr scans
v0.3 short address fix for starknet 64 character addresses