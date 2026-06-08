var dashboardModel = require("../models/dashboardModel");

function buscarTempoReal(req, res) {
    var idEstufa = req.params.idEstufa;
    var idSensorSolo = req.params.idSensorSolo; 

    dashboardModel.buscarTempoReal(idEstufa, idSensorSolo)
        .then(resultado => {
            res.json(resultado);
        })
        .catch(erro => {
            console.error("Erro ao buscar tempo real:", erro);
            res.status(500).json(erro);
        });
}

function buscarDadosdaSemana(req, res) {
    var idEstufa = req.params.idEstufa;
    var idSensorSolo = req.params.idSensorSolo; 

    dashboardModel.buscarDadosdaSemana(idEstufa, idSensorSolo)
        .then(resultado => {
            res.json(resultado);
        })
        .catch(erro => {
            console.error("Erro ao buscar tempo real:", erro);
            res.status(500).json(erro);
        });
}

function buscarDadosHoje(req, res) {
    var idEstufa = req.params.idEstufa;
    var idSensorSolo = req.params.idSensorSolo; 

    dashboardModel.buscarDadosHoje(idEstufa, idSensorSolo)
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            console.error("Erro ao buscar dados de hoje:", erro);
            res.status(500).json(erro.sqlMessage || erro);
        });
}

function buscarDadosSemana(req, res) {
    dashboardModel.buscarDadosSemana()
        .then(function (resultado) { res.json(resultado); })
        .catch(function (erro) { res.status(500).json(erro.sqlMessage || erro); });
}

function buscarAlertasHoje(req, res) {
    dashboardModel.buscarAlertasHoje()
        .then(function (resultado) { res.json(resultado); })
        .catch(function (erro) { res.status(500).json(erro.sqlMessage || erro); });
}

function buscarResumoEstufas(req, res) {
    dashboardModel.buscarResumoEstufas()
        .then(function (resultado) { res.json(resultado); })
        .catch(function (erro) { res.status(500).json(erro.sqlMessage || erro); });
}

function buscarEstufasEmpresa(req, res) {
    var idEmpresa = req.params.idEmpresa;
    if (!idEmpresa) {
        return res.status(400).json({ erro: "ID da empresa não informado" });
    }

    dashboardModel.buscarEstufasEmpresa(idEmpresa)
        .then(function(resultado) { res.json(resultado); })
        .catch(function(erro) {
            console.error(erro);
            res.status(500).json({ erro: "Erro ao buscar estufas" });
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
    buscarTempoReal,   
    buscarDadosHoje,
    buscarDadosSemana,
    buscarAlertasHoje,
    buscarResumoEstufas,
    buscarEstufasEmpresa,
    buscarDadosdaSemana
    buscarAlertasHoje,
    buscarSensores
};