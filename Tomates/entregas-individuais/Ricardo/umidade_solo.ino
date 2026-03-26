const int ValorAr = 550;
const int ValorAgua = 230;

int valorUmidadeSolo = 0;
float porcentagemUmidade = 0; 

void setup() {
  Serial.Begin(9600);

}

void loop() {
  valorUmidadeSolo = analogRead(A5);

  int faixa = ValorAr - ValorAgua;

  int distancia = ValorAr - valorUmidadeSolo;

  porcentagemUmidade = (float)distancia / faixa * 100.00;

  if (porcentagemUmidade < 0) porcentagemUmidade = 0;
  if (porcentagemUmidade > 100) porcentagemUmidade = 100;

 // Serial.print("Leitura Bruta: ");
  Serial.print(valorUmidadeSolo);
  Serial.print (';');
  //Serial.print(" | Umidade: ")
  Serial.println(porcentagemUmidade);
  //Serial.println(" % ");

  delay(1000); 
}
