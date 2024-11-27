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
    crowdfundingdapp: "Crowdfunding DApp",
    userContributions: "Sovereign and decentralized Crowdfunding",
    project: "Project:",
    goal: "Goal:",
    timeleft: "Time Left:",
    days: "Days",
    hours: "Hours",
    minutes: "Minutes",
    seconds: "Seconds",
    aproximatedly: "approximately",
    contribute: "PARTICIPATE",
    yourcontribution: "Your participation: ",
    smartcontractdetails: "- Smart contract details",
    contract: "Contract",
    chain: "Chain",
    raisedamount: "Raised amount",
    status: "State",
    projectdetails: "- Project details",
    gitrepository: "Git repository",
    whitepaper: "White paper",
    contributors: "Participants",
    tutorials: "Tutorials",
    howtocontribute: "How to contribute?(PDF)",
    receptor:"Receptor",
    period:"Period",
    donations:"Donations",
    raised:"Raised",
    donatehere:"Donate to this address",
    donateherechain:"to this chain",
    close:'close',
    donate:"donate"
  },
  fr: {
    crowdfundingdapp: "DApp de financement participatif",
    userContributions: "Financement participatif souverain et décentralisé",
    project: "Projet:",
    goal: "Objectif:",
    timeleft: "Temps restant:",
    days: "Jours",
    hours: "Heures",
    minutes: "Minutes",
    seconds: "Secondes",
    aproximatedly: "environ",
    contribute: "PARTICIPER",
    yourcontribution: "Votre participation: ",
    smartcontractdetails: "- Détails du contrat intelligent (smart contracts)",
    contract: "Contrat",
    chain: "Chaîne",
    raisedamount: "Montant collecté",
    status: "Status",
    projectdetails: "- Détails du projet",
    gitrepository: "Dépôt git",
    whitepaper: "livre blanc",
    contributors: "Participants",
    tutorials: "Tutoriels",
    howtocontribute: "Comment contribuer?(PDF)",
    receptor:"Receptor",
    period:"Period",
    donations:"Donations",
    raised:"Soulevé",
    donatehere:"Faites vos don dans cette adress",
    donateherechain:"dans ce chaine",
    close:'fermer',
    donate:"participer"
  },
  es: {
    crowdfundingdapp: "DApp de financiación colectiva ",
    userContributions: "Crowdfunding soberano y descentralizado",
    project: "Projecto:",
    goal: "Meta:",
    timeleft: "Tiempo restante:",
    days: "Días",
    hours: "Horas",
    minutes: "Minutos",
    seconds: "Segundos",
    aproximatedly: "aproximadamente",
    contribute: "PARTICIPAR",
    yourcontribution: "Tu participación: ",
    smartcontractdetails:
      "- Detalles del contrato inteligente (Smart contract)",
    contract: "Contrato",
    chain: "Cadena",
    raisedamount: "Monto recaudado",
    status: "Estado",
    projectdetails: "- Detalles del proyecto",
    gitrepository: "Repositorio git",
    whitepaper: "Proyecto",
    contributors: "Participantes",
    tutorials: "Tutoriales",
    howtocontribute: "¿Cómo contribuir?(PDF)",
    receptor:"Receptor",
    period:"Periodo",
    donations:"Donations",
    raised:"Colectado",
    donatehere:"Donar en esta address",
    donateherechain:"en esta red",
    close:'cerrar',
    donate:"donar"
  },
};

function set_lang(dictionary) {
  document.querySelectorAll("[data-translate]").forEach(function (element) {
    if (element.nodeName === "INPUT" || element.nodeName === "TEXTAREA") {
      // element.placeholder = dictionary[element.dataset.translate];
      console.log("setlang found a Textarea");
    } else {
      element.innerHTML = dictionary[element.dataset.translate];
      //   console.log('setlant didnt found a Textarea');
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
  console.log("langswitch.onchange");
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
} //fin reloadTranslations
