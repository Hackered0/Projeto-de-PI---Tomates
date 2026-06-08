var database = require("../database/config");

function buscarTempoReal(idEstufa, idSensorSolo) {
    var instrucao = `
        SELECT 
            (SELECT rd.temperatura 
             FROM retorno_dados rd 
             JOIN sensor s ON rd.idSensor = s.id_sensor 
             WHERE s.idEstufa = ${idEstufa} AND s.tipo_sensor = 'DHT11' 
             ORDER BY rd.id_dados DESC LIMIT 1) AS temperatura,
             
            (SELECT rd.umidadeAr 
             FROM retorno_dados rd 
             JOIN sensor s ON rd.idSensor = s.id_sensor 
             WHERE s.idEstufa = ${idEstufa} AND s.tipo_sensor = 'DHT11' 
             ORDER BY rd.id_dados DESC LIMIT 1) AS umidadeAr,
             
            (SELECT rd.dtCaptura 
             FROM retorno_dados rd 
             JOIN sensor s ON rd.idSensor = s.id_sensor 
             WHERE s.idEstufa = ${idEstufa} AND s.tipo_sensor = 'DHT11' 
             ORDER BY rd.id_dados DESC LIMIT 1) AS dtCaptura, -- CORREÇÃO AQUI (De dtCapturaAr para dtCaptura)
             
            (SELECT rd.umidadeSolo 
             FROM retorno_dados rd 
             WHERE rd.idSensor = ${idSensorSolo} 
             ORDER BY rd.id_dados DESC LIMIT 1) AS umidadeSolo,
             
            (SELECT rd.dtCaptura 
             FROM retorno_dados rd 
             WHERE rd.idSensor = ${idSensorSolo} 
             ORDER BY rd.id_dados DESC LIMIT 1) AS dtCapturaSolo;
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function buscarDadosHoje(idEstufa, idSensorSolo) {
   
    var instrucao = `
        SELECT 
            MAX(CASE WHEN s.tipo_sensor = 'DHT11' THEN rd.temperatura END) AS temperatura,
            MAX(CASE WHEN s.tipo_sensor = 'DHT11' THEN rd.umidadeAr END) AS umidadeAr,
            MAX(CASE WHEN s.id_sensor = ${idSensorSolo} THEN rd.umidadeSolo END) AS umidadeSolo,
            DATE_FORMAT(rd.dtCaptura, '%Y-%m-%d %H:%i:00') AS dtCaptura
        FROM retorno_dados rd
        INNER JOIN sensor s ON s.id_sensor = rd.idSensor
        WHERE s.idEstufa = ${idEstufa} 
          AND (s.tipo_sensor = 'DHT11' OR s.id_sensor = ${idSensorSolo})
        GROUP BY DATE_FORMAT(rd.dtCaptura, '%Y-%m-%d %H:%i:00')
        ORDER BY dtCaptura DESC
        LIMIT 144;
    `;
    return database.executar(instrucao);
}

function buscarEstufasEmpresa(idEmpresa) {
    var instrucao = `
        SELECT
            e.id_estufa,
            e.nome AS nome_estufa,
            ROUND(AVG(ultimos.temperatura),1) AS temperatura,
            ROUND(AVG(ultimos.umidadeAr),1) AS umidadeAr,
            MAX(ultimos.dtCaptura) AS dtCaptura
        FROM estufa e
        JOIN sensor s ON s.idEstufa = e.id_estufa
        JOIN (
            SELECT
                rd.idSensor,
                rd.temperatura,
                rd.umidadeAr,
                rd.dtCaptura
            FROM retorno_dados rd
            INNER JOIN (
                SELECT idSensor, MAX(id_dados) AS ultimoRegistro
                FROM retorno_dados
                GROUP BY idSensor
            ) ultimo ON rd.id_dados = ultimo.ultimoRegistro
        ) ultimos ON ultimos.idSensor = s.id_sensor
        WHERE e.idEmpresa = ${idEmpresa}
        GROUP BY e.id_estufa, e.nome
        ORDER BY e.id_estufa;
    `;
    return database.executar(instrucao);
}

function buscarDadosdaSemana(idEstufa, idSensorSolo) {
    var instrucao = `
        SELECT 
            ROUND(AVG(CASE WHEN s.tipo_sensor = 'DHT11' THEN rd.temperatura END), 1) AS temperatura,
            ROUND(AVG(CASE WHEN s.tipo_sensor = 'DHT11' THEN rd.umidadeAr END), 1) AS umidadeAr,
            ROUND(AVG(CASE WHEN s.id_sensor = ${idSensorSolo} THEN rd.umidadeSolo END), 1) AS umidadeSolo,
            DATE_FORMAT(rd.dtCaptura, '%Y-%m-%d') AS dtCaptura
        FROM retorno_dados rd
        INNER JOIN sensor s ON s.id_sensor = rd.idSensor
        WHERE s.idEstufa = ${idEstufa} 
          AND (s.tipo_sensor = 'DHT11' OR s.id_sensor = ${idSensorSolo})
          AND rd.dtCaptura >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
        GROUP BY DATE_FORMAT(rd.dtCaptura, '%Y-%m-%d')
        ORDER BY dtCaptura ASC;
    `;
    
    console.log("Executando a instrução SQL da Semana: \n" + instrucao);
    return database.executar(instrucao);
}
function buscarDadosSemana() { return Promise.resolve([]); }
function buscarAlertasHoje() { return Promise.resolve([]); }
function buscarResumoEstufas() { return Promise.resolve([]); }

module.exports = {
    buscarDadosHoje,
    buscarTempoReal,
    buscarEstufasEmpresa,
    buscarDadosSemana,
    buscarAlertasHoje,
    buscarResumoEstufas,
    buscarDadosdaSemana
};