//Path Server
//https://z1groinscc.execute-api.us-east-1.amazonaws.com
const String pathServer = "https://z1groinscc.execute-api.us-east-1.amazonaws.com/";
//const String pathServer = "http://10.0.2.2:9000/";


//Path Enviroment
const String stage = "dev";

//PathServices
//Auth
const String loginService = "/login";

//Father
const String childrenService = "/apoderados/:1/estudiantes";
const String qrPrincipalService = "/qr/apoderado/:1";
const String listAssignService = "/apoderados/:1/autorizaciones";

//Charger
const String searchChargerService = "/responsables";

//Assigns
const String createNewAssignService = "/autorizaciones";
const String updateAssignService = "/autorizaciones/:1";