// Sensor de Temperatura e Umidade
#include "DHT.h

#define TIPO_SENSOR DHT11
const int PINO_SENSOR_DHT11 = A0;

DHT sensorDHT (PINO_SENSOR_DHT11, TIPO_SENSOR);
// Sensor Umidade do Solo

const int ValorAr = 550;
const int ValorAgua = 230;

int valorUmidadeSolo = 0;
float porcentagemUmidade = 0; 

void setup() {

  Serial.begin(9600);
  sensorDHT.begin();

}

void loop() {
  // Sensor de Temperatura e Umidade 
  float umidade = sensorDHT.readHumidity();
  float temperatura = sensorDHT.readTemperature();

  if (isnan(temperatura) || isnan(umidade)) {
    Serial.println ("Erro ao ler os dados do sensor");
  } else {
    Serial.print ("Umidade: ");
    Serial.print (umidade);
    Serial.print (" % ");
    Serial.print ("Temperatura: ");
    Serial.print (temperatura);
    Serial.println ("ºC ");
  }
  // Sensor de umidade do Solo
  valorUmidadeSolo = analogRead(A5);

  int faixa = ValorAr - ValorAgua;

  int distancia = ValorAr - valorUmidadeSolo;

  if (porcentagemUmidade < 0) porcentagemUmidade = 0;
  if (porcentagemUmidade > 100) porcentagemUmidade = 100;

  Serial.print("Leitura Bruta: ");
  Serial.print(valorUmidadeSolo);
  Serial.print(" | Umidade: ")
  Serial.print(porecentagemUmidade);
  Serial.println(" % ");

}

