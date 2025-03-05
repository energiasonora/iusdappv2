# Contribute with Stealth Address :
Donor computes the stealth address off-chain using the recipient's public key.
Donor calls the contribute function, specifying the stealth address:

```
contribute(1, "AnonymousDonor", true); // Pass the stealth address as part of the transaction

```

# Contribute Directly :
Donor calls the contribute function without using a stealth address:

```
contribute(1, "DirectDonor", false);
```

# todo
crear una widthraw function que permita recaudar los fondos de cada stealth address usada
