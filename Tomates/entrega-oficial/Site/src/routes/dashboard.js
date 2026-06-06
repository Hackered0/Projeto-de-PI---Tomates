var express = require("express");
var router = express.Router();


var dashboardController = require("../controllers/dashboardController");

router.post("/cadastrar", function (req, res) {
   
    dashboardController.cadastrar(req, res);
});

router.get("/listar", function (req, res) {

    dashboardController.listar(req, res);
});

module.exports = router;