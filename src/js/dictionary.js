
    /******************************************************************************************************************************************************************************************
    .) DICTIONARY
    ********************************************************************************************************************************************************************************************/
    var userLang = navigator.language || navigator.userLanguage;
    var lang = navigator.language || navigator.userLanguage; //no ?s necessary

    const langs = document.querySelectorAll("[lang]");
    const langen = document.querySelectorAll('[lang="en"]');
    const langfr = document.querySelectorAll('[lang="fr"]');
    const langes = document.querySelectorAll('[lang="es"]');
    var dictionary = {
      en: {
        IAMDescription: 'IAM-(Your Names initials )-(Your date of birth )',
        names: 'Name/s',
        surnames: 'Surname/s',
        name: 'Name and surname initials',
        placeofbirth: 'place of birth',
        address: 'address',
        createIAM: "Create your DID",
        addDocs: 'Public Documents',
        title: "Upload to IPFS",
        upload: "Upload",
        adddoc: "+ Add document",
        addcourtesytranslation: "Add courtesy translation",
        testifyDocument: "testify Document",
        preview: "preview",
        delete: "delete",
        selPDFfirst: "you have to select a PDF first!",
        setTitlefirst: " Give this upload a title first...",
        bravo: "Bravo!",
        uploadtoipfs: "upload your documents to InterPlanetary File System!",
        desc: 'Built on top of the InterPlanetary File System (IPFS), a distributed and content-addressed file system designed to be reliable, resilient and future- proof.',
        signThisToLogin: "Welcome to IURIS NATURALIS! Sign this message to prove you have access to this wallet and we'll log you in.This won't cost you any Ether.",
        back: 'back',
        nft_name: "Title",
        enterDescription: 'Description',
        enterDate: 'Date of birth',
        pricePerItem: 'price',
        address: 'address',
        econtact: 'electronic contact',
        wallet: 'Wallet',
        uploadcourtesytranslations: "upload courtesy translations of this document",
        addanother: " Add another",
        close: "Close",
        setpassword: "Set password",
        createwallet: "CREATE WALLET",
        restorewallet: "RESTORE WALLET",
        walletCreation: "CREATING WALLET",
        createpasswordtoencryptwallet: 'Create a password to encrypt your local wallet',
        yourkeysyourdata: "Your keys, your data",
        utilsfortheautodetermined: "Publish your self-determination documents according to the OPPT mechanism",
        config: "Config",
        burntoken: "Burn UP token",
        filloutfield: "Please fill out this field",
        publicipfs: "+ Add public document",
        decryptingwallet: "Decrypting wallet ...",
        restore: "Restore",
        walletrestore: "Restore wallet",
        start: "Tutorial",
        actions: "Actions",
        youareowneroftoken: "YOUR ARE OWNER OF TOKEN ",
        send: "send",
        cancel: "Cancel",
        updatenft: "Update NFT",
        addAttests: "MAKE ATESTATION",
        attestations: "Attestations",
        log1: "You are revoking your IAMcode attestation as you delete it!. Would you like to continue?(you need gas to pay for the transaction) ",
        quest1: "Delete IAM attestation?",
        yes: "Yes",
        connected: "Connected!",
        revoke: "Yes, revoke it!",
        attestation: "Attestation",
        documentdeleted: "document deleted!",
        orderupdated: "Order updated",
        wontbeabletorevertthis: "You won't be able to revert this!",
        sure: "Are you sure?",
        fileuploaded: "File uploaded to IPFS",
        attestationsigned: "Attestation signed! ",
        unlocklocalwallet: "Unlock your LOCALWALLET",
        decryptwallet: "Decrypt wallet",
        uploadandattest: "Processus de téléchargement et d’attestation",
        uploadsignature: "Upload your autograph",
        uploadavatar: "Upload your avatar",
        attesting: "Creating the attestation",
        unlocklocalwallet: "Unlock your LOCALWALLET",
        deletedidtitle: "Delete DId?",
        deletediddescription: "You are about to delete your Decentralized Identifier and all actions associated with it!. Would you like to continue?",
        published:'Published!',
        addAddress: "Add a new address",
        autograph:"Autograph",
        uploadimagefield:'Please upload image',
        uploadedimagefield:"Image uploaded!",
        completeallfields:"Complete all fields!",
        disconnect:"Disconnect",
        connect:"Connect",
        uploadbutton:"+ Upload",
        readingrecord:"reading did record... this may take a while",
        checkingnetwork:"checking network...",
        checkingnft:"checking NFT (token Id)...",
        newtitle:"New title",
        scanqr: "Scan QR",
        unlockWallet: "Unlock your wallet",
        rememberPassword:"Remember password",
        buygas: "Buy gas",
        askpeer: "ask your peer to pay for the gas",
        youarebackonline: "Online ✅",
        youareoffline: "Offline 🚫 ",
        settings:"SETTINGS",
        userinfo:"User Information",
        changeavatar:"Change avatar",
        aliasname:"Alias Name",
        edit:"Edit",
        enteraliasname:"Enter alias name",
        viewmnemonic:"VIEW MNEMONIC PHRASE",
        writedown:"Write down your mnemonic phrase to access your wallet in the future!",
        keysmanagement:"Keys management",
        backup:"Backup",
        restore:"Restore",
        token:"TOKEN",
        loadingtokens:"loading tokens...",
        notifications:'Notifications',
        enablenotifications:"Enable notificacions",
        enabled:"Enabled",
        language:"Language",
        contacts:"Contacts",
        save:"Save",
        import:"Import",
        chats:"Chats",
        createmultisigchat:"Create multisig chat",
        joingroupethroughqr:"JOIN GROUP THROGH QR",
        lock:"Block"


      },
      fr: {
        IAMDescription: 'IAM-(Les initiales de vos noms )-(Votre date de naissance )',
        names: 'Prenom/s',
        surnames: 'Nome/s',
        name: 'initials de votre Nom et prenom',
        placeofbirth: 'lieu de naissance',
        address: 'address',
        createIAM: "Creé votre DID",
        addDocs: 'Documents publics',
        title: "Télécharger sur IPFS",
        upload: "Télécharger",
        adddoc: "+ Ajouter document",
        addcourtesytranslation: "Ajouter une traduction de courtoisie",
        testifyDocument: "témoigner Document",
        preview: "prévisualisation",
        delete: "effacer",
        selPDFfirst: "vous devez d'abord sélectionner un PDF!",
        setTitlefirst: " Donnez d'abord un titre à ce téléchargement...",
        bravo: "Bravo!",
        uploadtoipfs: "TÉLÉCHARGER tes fichiers PDF sur le système de fichiers interplanétaire!",
        desc: `Construit sur le système de fichiers interplanétaire(IPFS), un système de fichiers contenu - adressable et distribué conçu pour être fiable, résilient et à l'épreuve du temps.`,
        signThisToLogin: "Bienvenue sur IURIS-NATURALIS! Signez ce message pour montrer que vous avez accès à votre clé privée pour vous connecter.Cela ne vous coûtera aucun Ether.",
        back: 'retour',
        nft_name: "Titre",
        enterDescription: "Description",
        enterDate: 'Date de naisance',
        pricePerItem: "Prix",
        address: 'adresse',
        econtact: 'contact électronique',
        wallet: 'Portefeuille',
        uploadcourtesytranslations: "télécharger des traductions de courtoisie de ce document",
        addanother: "Ajouter un autre",
        close: "Fermer",
        setpassword: "Définir le mot de passe",
        createwallet: "CRÉER LE WALLET",
        restorewallet: "RESTAURER WALLET",
        walletCreation: "CRÉATION DU PORTEFEUILLE",
        createpasswordtoencryptwallet: 'Créer un mot de passe pour chiffrer votre portefeuille local',
        yourkeysyourdata: "Vos clés, vos données",
        utilsfortheautodetermined: "Publiez vos documents d'autodétermination selon le mécanisme OPPT",
        config: "Paramètres",
        burntoken: "Brûler UP token",
        filloutfield: "Veuillez remplir ce champ",
        publicipfs: "Publiquer dans le DID",
        decryptingwallet: "Décryptage du portefeuille...",
        restore: "Restaurer",
        walletrestore: "Restaurer wallet",
        start: "Tutorial",
        actions: "Actions",
        youareowneroftoken: "VOUS ÊTES PROPRIÉTAIRE DU JETON ",
        send: "Envoyer",
        cancel: "Annuler",
        updatenft: "Mettre à jour NFT",
        addAttests: "FAIRE L'ATTESTATION",
        attestations: "Attestations",
        log1: "Vous révoquez votre attestation IAMcode en la supprimant!. Voulez-vous continuer? (vous devez payer la transaction) ",
        quest1: "Supprimer l'attestation IAMcode?",
        yes: "Oui",
        connected: "Connecté!",
        revoke: "Oui, révoque-le",
        attestation: "Attestation",
        documentdeleted: "document supprimé!",
        orderupdated: "Order updated",
        wontbeabletorevertthis: "Vous ne pourrez pas revenir en arrière!",
        sure: "Êtes-vous sûr?",
        fileuploaded: "Fichier téléchargé sur IPFS",
        attestationsigned: "Attestation signée! ",
        unlocklocalwallet: "Débloquez votre LOCALWALLET",
        decryptwallet: "Décrypter le wallet",
        uploadandattest: "Télécharger et attester",
        uploadsignature: "Téléchargez votre autographe",
        uploadavatar: "Téléchargez votre avatar",
        attesting: "Créer l'attestation",
        unlocklocalwallet: "Débloquez votre LOCALWALLET",
        deletedidtitle: "Supprimer le DID?",
        deletediddescription: "Vous êtes sur le point de supprimer votre identifiant décentralisé et toutes les actions qui y sont associées !. Voulez-vous continuer?",
        published:'Publié!',
        addAddress: "Ajouter un nouveau contact",
        autograph:"Autographe",
        uploadimagefield:"Veuillez télécharger l'image",
        uploadedimagefield:"Image téléchargée!",
        completeallfields:"Remplissez tous les champs!",
        disconnect:"Déconnecter",
        connect:"Connecter",
        uploadbutton:"+ Télécharger",
        readingrecord:"lecture du DID enregistré... soyez patient",
        checkingnetwork:"vérification du réseau...",
        checkingnft:"vérification de NFT (ID de jeton)...",
        newtitle:"Nouveau titre",
        scanqr: "scanner le code QR",
        unlockWallet: "Débloquez votre portefeuille",
        rememberPassword:"Se souvenir du mot de passe",
        buygas: "Acheter du gas",
        askpeer: "Demander le paiement du gaz à votre peer",
        youarebackonline: "Connectée ✅ ",
        youareoffline: "Hors ligne 🚫",
        settings:"Paramètres",
        userinfo:"Infos utilisateur",
        changeavatar:"Modifier l'avatar",
        aliasname:"Alias (nom)",
        edit:"Editer",
        enteraliasname:"Remplissez l'alias (nom)",
        viewmnemonic:"Afficher la mnémonique",
        writedown:"Écris ta phrase mnémonique pour accéder à ton portefeuille à l'avenir!",
        keysmanagement:"Gestion des clés",
        backup:"Sauvegarde",
        restore:"Restaurer",
        token:"JETON",
        loadingtokens:"cargando tokens...",
        notifications:'Notifications',
        enablenotifications:"Activer notificacions",
        enabled:"Actif",
        language:"Langue",
        contacts:"Contacts",
        save:"Enregistrer",
        import:"Importer",
        chats:"Chats",
        createmultisigchat:"Creer chat multisig",
        joingroupethroughqr:"REJOINDRE GROUP AVEC QR",
        lock:"Bloqueer"



      },
      es: {
        IAMDescription: 'IAM-(Las iniciales de su nombre )-(fecha de nacimiento )',
        names: 'Nombre/s',
        surnames: 'Apellido/s',
        name: 'Iniciales de su nombre y apellido',
        placeofbirth: 'lugar de nacimiento',
        address: 'direccion',
        createIAM: "Crear DID",
        addDocs: 'Documentos públicos',
        title: "Sube tus documentos a IPFS",
        upload: "Cargar documento",
        adddoc: "Agregar documento",
        addcourtesytranslation: "Agregar traducción de cortesía",
        testifyDocument: "testificar documento",
        preview: "Previsualizar",
        delete: "Borrar",
        selPDFfirst: "¡Tienes que seleccionar un PDF primero!",
        setTitlefirst: " Dale un título a antes de subir el documento...",
        bravo: "¡Bravo!",
        uploadtoipfs: "¡Sube tus documentos al sistema de archivos interplanetario!",
        desc: 'Construido sobre el Sistema de archivos interplanetarios (IPFS), un sistema de archivos distribuido y dirigido por contenido diseñado para ser confiable, resistente a la censura y de prueba futura.',
        signThisToLogin: "¡Bienvenido a IURIS-NATURALIS! Firme este mensaje para demostrar que tiene acceso a su llave privada para ingresar.Esto no le costará ningún Ether.",
        back: 'volver',
        nft_name: "titulo",
        enterDescription: 'Descripcion',
        enterDate: 'Fecha de nacimiento',
        pricePerItem: 'precio',
        address: 'Direccion',
        econtact: 'contacto electronico',
        wallet: 'Billetera',
        uploadcourtesytranslations: "subir traducciones de cortesía de este documento",
        addanother: "Agrega otro",
        close: "Cerrar",
        setpassword: "Configurar la Contraseña",
        createwallet: "CREAR LA WALLET",
        restorewallet: "RESTAURAR LA WALLET",
        walletCreation: "CREANDO WALLET",
        createpasswordtoencryptwallet: 'cree una contraseña para encriptar su wallet local',
        yourkeysyourdata: "Tus llaves, tus datos",
        utilsfortheautodetermined: "Publique sus documentos de autodeterminacion segun el mecanismo OPPT",
        config: "Configuración",
        burntoken: "Quemar UP token",
        filloutfield: "Por favor rellene este campo",
        publicipfs: "Publicar en DID",
        decryptingwallet: "Descifrando billetera ...",
        restore: "Restaurar",
        walletrestore: "Restaurar wallet",
        start: "Tutorial",
        actions: "Acciones",
        youareowneroftoken: "ERES CREADOR DEL TOKEN ",
        send: "Enviar",
        cancel: "Cancelar",
        updatenft: "Actualizar NFT",
        addAttests: "DAR TESTIMONIO",
        attestations: "Atestaciones",
        log1: "Estás revocando tu certificación de IAMcode al eliminarla!. Deseas continuar? (debes para pagar por la transacción) ",
        quest1: "¿Eliminar la atestacion del codigo IAM?",
        yes: "Sí",
        connected: "Conectado!",
        revoke: "Si, revócalo!",
        attestation: "Atestación",
        documentdeleted: "Documento borrado",
        orderupdated: "Orden actualizado",
        wontbeabletorevertthis: "¡No podrás revertir esto!",
        sure: "¿Está seguro?",
        fileuploaded: "Archivo subido a IPFS",
        attestationsigned: "¡Atestación firmada! ",
        unlocklocalwallet: "Desbloquear LOCALWALLET",
        decryptwallet: "Desbloquando wallet",
        uploadandattest: "Subir y attestar",
        uploadsignature: "Sube tu autógrafo",
        uploadavatar: "Sube tu avatar",
        attesting: "Creando atestación",
        unlocklocalwallet: "Desbloquea tu LOCALWALLET",
        deletedidtitle: "Eliminar DID?",
        deletediddescription: "¡Estás a punto de eliminar tu Identificador Descentralizado y todas las acciones asociadas a éste!. ¿Deseas continuar?",
        published:'Publicado!',
        addAddress: "Agregar una nuevo contacto",
        autograph:"Autógrafo",
        uploadimagefield:"Suba una imagen",
        uploadedimagefield:"¡Imagen subida!",
        completeallfields:"¡Completa todos los campos!",
        disconnect:"Desconectar",
        connect:"Conectar",
        uploadbutton:"+ Cargar",
        readingrecord:"leyendo DID... tenga paciencia",
        checkingnetwork:"comprobando la red...",
        checkingnft:"comprobando NFT (ID de token)...",
        newtitle:"Nuevo nombre de archivo",
        scanqr: "Escanear QR",
        unlockWallet: "Desbloquear billetera",
        rememberPassword:"Recordar password",
        buygas: "Comprar gas",
        askpeer: "demandar pago de gas",
        youarebackonline: "Conectado ✅",
        youareoffline: "Desconectado 🚫",
        settings:"CONFIGURACION",
        userinfo:"Informacion de usuario",
        changeavatar:"Cambiar avatar",
        aliasname:"Alias de usuario",
        edit:"Editar",
        enteraliasname:"Completar con alias de usuario",
        viewmnemonic:"REVELAR FRASE MNEMONICA",
        writedown:"Guarda tu frase mnemonica para acceder a tu billetera en el futuro!",
        keysmanagement:"Manejo de llaves",
        backup:"Respaldo",
        restore:"Restauracion",
        token:"TOKEN",
        loadingtokens:"cargando tokens...",
        notifications:'Notificaciones',
        enablenotifications:"Activar notificaciones",
        enabled:"Activado",
        language:"Idioma",
        contacts:"Contactos",
        save:"Guardar",
        import:"Importar",
        chats:"Chats",
        createmultisigchat:"Crear chat multisig",
        joingroupethroughqr:"UNIRSE A GROUPO CON QR",
        lock:"Bloquear"

      }
    };

    function set_lang(dictionary) {

      document.querySelectorAll("[data-translate]").forEach(function (element) {
        if (element.nodeName === "INPUT" || element.nodeName === "TEXTAREA") {
          // element.placeholder = dictionary[element.dataset.translate];
          console.log('setlang found a Textarea');
        } else {
          element.innerHTML = dictionary[element.dataset.translate];
          // console.log('setlant didnt found a Textarea');

        }
      });


    }

    function selectText(lang) {
      switch (lang) {
        case "en":
          set_lang(dictionary.en);
          globalLang = "en";
          break;
        case "fr":
          set_lang(dictionary.fr);
          globalLang = "fr";
          break;
        case "es":
          set_lang(dictionary.es);
          globalLang = "es";
          break;
        default:
          set_lang(dictionary.en);
          globalLang = "en";
      }
    }

    // STORAGE

    // Swap languages when menu changes
    let langswitch = document.getElementById("langswitch");
    langswitch.onchange = function () {
      var lang = this.value;
      localStorage.setItem("lang", lang);
      selectText(lang);
    };


    function reloadTranslations() {

      let savedLang = localStorage.getItem("lang");
      if (savedLang) {
        let element = document.querySelector(`option[value='${savedLang}']`);
        element.selected = true;
        selectText(savedLang);
      } else {
        console.log("NO hay LANG GUARDADO, muestra default lang: en ");
        set_lang(dictionary.en);
        globalLang = "en";
      }
    }//fin reloadTranslations


