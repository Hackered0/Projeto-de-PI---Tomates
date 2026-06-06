var express = require("express");
var router = express.Router();


var estufasController = require("../controllers/estufasController");

router.post("/cadastrar", function (req, res) {
   
    estufasController.cadastrar(req, res);
});

router.get("/listar", function (req, res) {

    estufasController.listar(req, res);
});

module.exports = router;