# STARKID

a DID managing tool to communicate your public and private data with sovereignty


# DEMO
https://starkid.web.app

# INSTALL
```
nvm use 18       
yarn                              
```

# RUN
```
yarn parcel src/index.html  --port 4444
```


# deploy to firebase

```
nvm use 18       
yarn parcel src/index.html --dist-dir public  --public-url ./
firebase deploy --only hosting:starkid
```

