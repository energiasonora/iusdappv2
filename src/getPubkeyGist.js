let wallet = new ethers.Wallet(privateKey);
let pubkey = wallet.signingKey.publicKey
console.log('pubkey:',pubkey)