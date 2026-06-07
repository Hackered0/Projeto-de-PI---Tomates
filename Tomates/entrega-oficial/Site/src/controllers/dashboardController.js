var dashboardModel = require("../models/dashboardModel");

function buscarUltimosDados(req, res) {
    dashboardModel.buscarUltimosDados()
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarDadosHoje(req, res) {
    dashboardModel.buscarDadosHoje()
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarDadosSemana(req, res) {
    dashboardModel.buscarDadosSemana()
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarAlertasHoje(req, res) {
    dashboardModel.buscarAlertasHoje()
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarSensores(req, res) {
    dashboardModel.buscarSensores()
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        });
}
module.exports = {
    buscarUltimosDados,
    buscarDadosHoje,
    buscarDadosSemana,
    buscarAlertasHoje,
    buscarSensores
};