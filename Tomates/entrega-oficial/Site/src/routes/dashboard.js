var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/ultimosDados", function (req, res) {
    dashboardController.buscarUltimosDados(req, res);
});

router.get("/dadosHoje", function (req, res) {
    dashboardController.buscarDadosHoje(req, res);
});

router.get("/dadosSemana", function (req, res) {
    dashboardController.buscarDadosSemana(req, res);
});

router.get("/alertasHoje", function (req, res) {
    dashboardController.buscarAlertasHoje(req, res);
});

module.exports = router;