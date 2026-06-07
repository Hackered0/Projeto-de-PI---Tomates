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

module.exports = {
    buscarUltimosDados,
    buscarDadosHoje,
    buscarDadosSemana,
    buscarAlertasHoje
};

// Fiz uma gambiarra pq n lembro como usa o current(), então se liga
// O arduino pega dados de 10 em 10 minutos
// 1 hora tem 60 minutos 
// Logo tem 6 regitros por hora 60/10 = 6 correto?
// Então em um dia é pego 24 x 6 = 144  que é o limit da função buscarDadosHoje.
// Agora para pegar dados da semana, a gente só multiplica esses 144 por 7, dando 1008
// Essa foi minha gambiarra 