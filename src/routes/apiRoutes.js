const router = require("express").Router();
const verifyJWT = require("../services/verifyJWT");
const userController = require("../controllers/userController");
const orgController = require("../controllers/orgController");
const eventoController = require("../controllers/eventoController");
const ingressoController = require("../controllers/ingressoController");

//Rotas userController
router.post("/user", userController.createUser);
router.get("/user", userController.getAllUsers);
router.put("/user", verifyJWT, userController.updateUser);
router.delete("/user/:id_usuario", verifyJWT, userController.deleteUser);
router.post("/login", verifyJWT, userController.loginUser);

//Rotas organizadorController
router.post("/org", orgController.createOrg);
router.get("/org", orgController.getAllOrgs);
router.put("/org", orgController.updateOrg);
router.delete("/org/:id_organizador", orgController.deleteOrg);

//Rotas eventoController
router.post("/evento", eventoController.createEvento);
router.get("/evento", eventoController.getAllEventos);
router.put("/evento", eventoController.updateEvento);
router.delete("/evento/:id_evento", eventoController.deleteEvento);
router.get("/evento/data", eventoController.getEventosPorData);
router.get("/evento/:data", eventoController.getEventosPorData7Dias);

//Rotas ingressoController
router.post("/ingresso", ingressoController.createIngresso);
router.get("/ingresso", ingressoController.getAllIngresso);
router.get("/ingresso/evento/:id", ingressoController.getByIdEvento);
router.put("/ingresso", ingressoController.updateIngresso);
router.delete("/ingresso/:id", ingressoController.deleteIngresso);

module.exports = router;
