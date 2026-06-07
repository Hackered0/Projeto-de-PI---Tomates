var database = require("../database/config");

function buscarUltimosDados() {
    var instrucao = `
        SELECT 
            temperatura,
            umidadeAr,
            umidadeSolo,
            dtCaptura
        FROM retorno_dados
        ORDER BY id_dados DESC
        LIMIT 1;
    `;

    return database.executar(instrucao);
}

// Dados de hj
function buscarDadosHoje() {
    var instrucao = `
        SELECT
            temperatura,
            umidadeAr,
            umidadeSolo,
            dtCaptura
        FROM retorno_dados
        ORDER BY id_dados DESC
        LIMIT 144;
    `;

    return database.executar(instrucao);
}

function buscarDadosSemana() {
    var instrucao = `
        SELECT
            temperatura,
            umidadeAr,
            umidadeSolo,
            dtCaptura
        FROM retorno_dados
        ORDER BY id_dados DESC
        LIMIT 1008;
    `;

    return database.executar(instrucao);
}

function buscarAlertasHoje() {
    var instrucao = `
        SELECT
            temperatura,
            umidadeAr,
            umidadeSolo
        FROM retorno_dados
        ORDER BY id_dados DESC
        LIMIT 144;
    `;

    return database.executar(instrucao);
}

function buscarSensores() {
    var instrucao = `
        SELECT
            nome_sensor,
            tipo_sensor,
            status
        FROM sensor;
    `;

    return database.executar(instrucao);
}

module.exports = {
    buscarUltimosDados,
    buscarDadosHoje,
    buscarDadosSemana,
    buscarAlertasHoje,
    buscarSensores
};

