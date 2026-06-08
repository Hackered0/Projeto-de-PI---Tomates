var express = require("express");
var router = express.Router();
var dashboardController = require("../controllers/dashboardController");


router.get("/dadosSemana", function (req, res) { dashboardController.buscarDadosSemana(req, res); });
router.get("/alertasHoje", function (req, res) { dashboardController.buscarAlertasHoje(req, res); });
router.get("/resumoEstufas", function (req, res) { dashboardController.buscarResumoEstufas(req, res); });
router.get("/estufas/:idEmpresa", function(req, res) { dashboardController.buscarEstufasEmpresa(req, res); });


router.get("/dadosHoje/:idEstufa/:idSensorSolo", dashboardController.buscarDadosHoje);
router.get("/tempoReal/:idEstufa/:idSensorSolo", dashboardController.buscarTempoReal);

router.get("/dadosHoje/:idEstufa/:idSensorSolo", dashboardController.buscarDadosHoje);
router.get("/tempoReal/:idEstufa/:idSensorSolo", dashboardController.buscarTempoReal);

router.get("/buscarDadosdaSemana/:idEstufa/:idSensorSolo", dashboardController.buscarDadosdaSemana);


module.exports = router;