<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>P2P BOB</title>

    <style>
        body {
            background-color: rgb(7, 42, 60);
            color: green;
        }

        #result {
            word-wrap: break-word;

        }
    </style>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css" />
    <script src="js/sweetalert2.all.min.js"></script>

    <style>
        body {
            background-color: black;
            color: green;
        }

        input {
            font-size: x-small;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .container {
            width: 100%;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .col {
            flex: 1;
            min-width: 300px;
            padding: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .addresses {
            width: 350px !important;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .half-width {
            width: 50%;
        }

        .addr {
            font-size: x-small;
        }

        #result {
            font-size: xx-small;
        }

        /* COLORED TOAST */
        .colored-toast.swal2-icon-success {
            background-color: #45bb00 !important;
        }

        .colored-toast.swal2-icon-error {
            background-color: #f27474 !important;
        }

        .colored-toast.swal2-icon-warning {
            background-color: #f8bb86 !important;
        }

        .colored-toast.swal2-icon-info {
            background-color: #3fc3ee !important;
        }

        .colored-toast.swal2-icon-question {
            background-color: #87adbd !important;
        }

        .colored-toast .swal2-title {
            color: white;
        }

        .colored-toast .swal2-close {
            color: white;
        }

        .colored-toast .swal2-html-container {
            color: white;
        }

  .light{
    position: fixed;
    top: 10px;
    right: 10px;
  }
    </style>
</head>

<body>
    <div id="lightButtonB" class="light">🔴</div>

    <h1>P2P BOB</h1>
    <p>receive and decrypt message</p>
    <p>Encrypt, sign and send message</p>


    <!-- Segunda fila con dos columnas -->
    <div class="row">
        <!-- Columna B - BOB -->
        <div class="col">
            <h3>BOB</h3>
            <span id="bobAddress" class="addr"></span>


            <div id="aliceMessageForm">
                <div class="mb-3">
                    <label for="bobmessageInput" class="form-label">Message</label>
                    <input type="text" class="form-control" id="bobmessageInput" placeholder="Type your message here">
                </div>

                <div id="bobHash">Hash:</div>

                <button type="submit" class="btn btn-primary" id="bobSend">Send</button>
            </div>


            <span id="bobResult" class="addr"></span>

        </div>
    </div>



    <!-- ------------ -->

    <div id="messagesResult"></div>
    <p>
    <div id="result"></div>

    <br><br>
    <div id="resultAddress"></div>



	
	<div class="search__related" id="chatBox">
	
	</div>



    <script src="js/ethers-6.13.2.umd.min.js"></script>





    <script type="module">

        import EthCrypto from 'eth-crypto';
        window.EthCrypto = EthCrypto;

        import { getPublicKey, utils } from '@noble/secp256k1';
        window.getPublicKey = getPublicKey;
        window.utils = utils;

        import { Client } from '@xmtp/xmtp-js'
		window.Client = Client;

        const toHexString = (bytes) => {
            return Array.from(bytes, byte => byte.toString(16).padStart(2, '0')).join('');
        };

        // -----------------------------------------
        // WALLET FUNCTIONS
        // -----------------------------------------


        // Function to derive an address on demand
        async function deriveAddressWallet(mnemonic, index) {
            const basePath = "m/44'/60'/0'/0/";
            const path = `${basePath}${index}`;
            const derivedNode = ethers.HDNodeWallet.fromPhrase(mnemonic, path);
            return derivedNode
        }


        async function aliceWallet() {
            let aliceMnemonic = localStorage.getItem('aliceMnemonic');
            if (!aliceMnemonic) {
                console.error('NO aliceMnemonic  in localStorage!');

                const randmnemonic = await ethers.HDNodeWallet.createRandom()
                aliceMnemonic = randmnemonic.mnemonic.phrase;
                localStorage.setItem('aliceMnemonic', aliceMnemonic);

            } else {
                console.log('aliceMnemonic is in localStorage!');

            }
            let aliceWall = deriveAddressWallet(aliceMnemonic, 0)
            return aliceWall
        }

        // 1- GET  PRIV KEY(IF not CREATE IT)
        async function bobWallet() {
            let bobMnemonic = localStorage.getItem('bobMnemonic');
            if (!bobMnemonic) {
                console.error('NO bobMnemonic  in localStorage!');

                const randmnemonic = await ethers.HDNodeWallet.createRandom()
                bobMnemonic = randmnemonic.mnemonic.phrase;
                console.log(bobMnemonic)
                localStorage.setItem('bobMnemonic', bobMnemonic);

            } else {
                console.log('bobMnemonic is in localStorage!');

            }

            let bobWall = deriveAddressWallet(bobMnemonic, 0)
            return bobWall

        }

        // -----------------------------------------
        // INIT
        // -----------------------------------------
        async function init() {
       

            let bobwallet = await bobWallet()
            b = bobwallet

            // DISPLAY ADDRESS
            document.getElementById('bobAddress').innerHTML = bobwallet.address
            console.log('bobwallet:', bobwallet.address)

            // SET DEFAULT MESSAGE
            document.getElementById('bobmessageInput').value = 'hola Alice'

            // GET MESSAGE HASH
            let hash = EthCrypto.hash.keccak256(document.getElementById('bobmessageInput').value)
            bobHash.innerText = "Hash: " + hash;
 
            let alicewallet = await aliceWallet()
            a= alicewallet;

            // CHAT
            const iusnaturalisxmtp = await Client.create(bobwallet)
            console.warn(' 🟢🟢🟢XMTP STARTED🟢🟢🟢🔴🟠🟡🔵⚫ ')
            document.getElementById('lightButtonB').innerHTML= '🟢'

            const conversations = iusnaturalisxmtp.conversations
			window.iusnaturalisxmtp = iusnaturalisxmtp;// make GLOBAL
			window.chats= iusnaturalisxmtp.conversations


            // LISTEN TO NEW CONVERSATIONS
            let userAddress= b.address
            let toAddr = a.address
            let shortTo = toAddr.substring(38, 42);

            conversation = await iusnaturalisxmtp.conversations.newConversation(toAddr)

            for await (const message of await conversation.streamMessages()) {
                const now = new Date();
                const hours = now.getHours().toString().padStart(2, '0'); // Ensure two-digit format
                const minutes = now.getMinutes().toString().padStart(2, '0'); // Ensure two-digit format
                const timestamp = `${hours}:${minutes}`;
                console.log('logMSG:', message)
                let preferedWallet = localStorage.getItem('preferedWallet');
                if (!preferedWallet) { console.log('NO PREFERED WALLET SET') }
                if (preferedWallet) { const values = preferedWallet.split(',').map(item => item.trim()); userAddress = values[1]; }
                if (message.senderAddress === userAddress) {
                    console.log('YOU')
                    chatBox.innerHTML += `<div><strong class='who'>You:</strong> ${message.content}<span class="timestamp">  ${timestamp} &check; </span></div>`;
                }
                if (message.senderAddress == toAddr) {
                    console.log('OTHER', shortTo)
                    mm = message;

                    //  DECRYPT FROM BOB's SIDE..........
                    const encryptedObject = EthCrypto.cipher.parse(message.content);
                    const decrypted = await EthCrypto.decryptWithPrivateKey( b.privateKey, encryptedObject );
                    const decryptedPayload = JSON.parse(decrypted);
                    // check signature
                    const senderAddress = EthCrypto.recover( decryptedPayload.signature, EthCrypto.hash.keccak256(decryptedPayload.message) );
                    console.log( 'Got message from ' + senderAddress + ': ' + decryptedPayload.message );
                    document.getElementById('chatBox').innerHTML += `<div><strong class='who notyou'>${shortTo}:</strong> ${decryptedPayload.message}<span class="timestamp">  ${timestamp} &check; </span></div>`;

                    }
                    console.log(`[${message.senderAddress}]: ${message.content}`)
                    chatBox.scrollTop = chatBox.scrollHeight;

            }

        }
        // init()


        // -----------------------------------------
        // SEND MSG
        // -----------------------------------------
        document.getElementById('bobSend').addEventListener('click', async function (event) {
            console.log('BOB SEND')

            let msg = document.getElementById('bobmessageInput').value
            console.log('msg:', msg)

            let bobwallet = await bobWallet()
            const bobPrivateKeyA = bobwallet.privateKey;
            console.log('bob private key:', bobPrivateKeyA)

            //1. firma el hash del mensaje
            //2. arma un payload con el mensaje + la firma 
            //3. lo encrpta
            //4. lo convierte en estring

            // 1.
            const signature = EthCrypto.sign(
                bobPrivateKeyA,
                EthCrypto.hash.keccak256(msg)
            );
            // console.log('signature:', signature)

            // 2.
            const payload = {
                message: msg,
                signature
            };
            console.log('🎯 payload:', payload)


            // 3.
            const encrypted = await EthCrypto.encryptWithPublicKey(
                ethers.getBytes(a.publicKey), // by encrypting with alice publicKey, only bob can decrypt the payload with his privateKey
                JSON.stringify(payload) // we have to stringify the payload before we can encrypt it
            );


            // 4.
            const encryptedString = EthCrypto.cipher.stringify(encrypted);
            console.log('⚠️ 🧳 🧮 Bob encrypted message to Alice:', encryptedString)

            // 5. send encrypted message
            // await conversation.send(encryptedString)


            // 5b. send optimistic encrypted message
            const preparedTextMessage = await conversation.prepareMessage(encryptedString);
            try {
                preparedTextMessage.send();
        } catch (e) {
                console.log("error!:", e)
            }

        })// fin function



        // / AUTOHASH BOB
        let bobHash = document.getElementById('bobHash')
        bobmessageInput.addEventListener("input", function () {
            console.log('text changed', bobmessageInput.value)
            const text = bobmessageInput.value;
            // const hash = ethers.sha256(ethers.toUtf8Bytes(text));
            let hash = EthCrypto.hash.keccak256(text)
            bobHash.innerText = "Hash: " + hash;
            bobHash.setAttribute("data-hash", hash);
            console.log('sha-256', hash);

        });



    </script>
</body>

</html>