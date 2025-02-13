Algoritmo "semnome"
// Disciplina   : Construcao de Algoritmos
// Professor   : Eugenio
// Descricao   :
// Autor(a)    : Gabriel de Oliveira Pereira e Pedro Henrique dos S. W Bezerra
// Data atual  : 18/09/2024
Var
   // Secao de Declaracoes das variaveis
   tabuleiro: vetor[1..8, 1..8] de caractere
   resposta: caractere

   xCavalo, yCavalo: inteiro
   xDama, yDama: inteiro
   xRei, yRei: inteiro
   xRei_B, yRei_B: inteiro

   x, y: inteiro

   // funcoes e procedimentos abaixo

Funcao repetir_jogo(): caractere
Var
   resposta: caractere
Inicio
   enquanto (resposta <> "s") e (resposta <> "n") faca
      escreva("Deseja testar uma nova configuracao? (s/n): ")
      leia(resposta)
   fimenquanto
   se (resposta = "s") entao
      posiciona_peca()
      retorne "s"
   senao
      se (resposta = "n") entao
         retorne "n"
      fimse
   fimse
fimfuncao


Procedimento verifica_entrada(peca: caractere)
Var
   posicao_valida: logico
Inicio
   //dois loops pra repetir input enquanto posicao do tabuleiro for invalida
   x <- 0
   y <- 0
   posicao_valida <- falso

   enquanto (posicao_valida = falso) faca
      escreva("Linha -> ")
      leia(x)

      escreva("Coluna -> ")
      leia(y)

      se (x >= 1) e (x <= 8) e (y >= 1) e (y <= 8) entao
         se (tabuleiro[x, y] = "") entao
            tabuleiro[x, y] <- peca
            posicao_valida <- verdadeiro
         senao
            escreval("Posicao ja ocupada. Tente outra.")
         fimse
      senao
         escreval("Linha ou coluna invalida. Tente novamente")
      fimse
   fimenquanto
fimprocedimento

Procedimento posiciona_peca()
Var
   i, j: inteiro
Inicio
   para i de 1 ate 4 faca
      escreva("Escolhendo a posicao da peca ")
      escolha i
      caso 1
         escreval("R.")
         verifica_entrada("R")
         xRei <- x
         yRei <- y
      caso 2
         escreval("C.")
         verifica_entrada("C")
         xCavalo <- x
         yCavalo <- y
      caso 3
         escreval("D.")
         verifica_entrada("D")
         xDama <- x
         yDama <- y
      caso 4

         escreval("X.")
         verifica_entrada("X")
         xRei_B <- x
         yRei_B <- y

         enquanto (reis_adjacentes() = verdadeiro) faca
            escreval("Os reis estao adjacentes. Tente novamente.")
            tabuleiro[x, y] <- ""
            verifica_entrada("X")
            xRei_B <- x
            yRei_B <- y
         fimenquanto
      fimescolha
   fimpara

   verifica_situacao()
fimescolha
fimProcedimento

// vai verificar se o rei nao esta em uma posicao invalida referente ao outro rei
Funcao reis_adjacentes(): logico
Var
   diferencaX, diferencaY: inteiro
Inicio
   diferencaX <- abs(xRei - xRei_B)
   diferencaY <- abs(yRei - yRei_B)

   se (diferencaX <= 1) e (diferencaY <= 1) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

// Para verificar se esta em xeque, afogamento, etc
Procedimento verifica_situacao()
Var

Inicio
   escreval("======== RESULTADO ========")
   se (ameaca_cavalo(xRei_B, yRei_B)) ou (ameaca_dama(xRei_B, yRei_B)) entao
      escreval("O alvo ta em xeque")
      movimentos_rei_b()
   senao
      se (nao ameaca_cavalo(xRei_B, yRei_B)) e (nao ameaca_dama(xRei_B, yRei_B)) entao
         movimentos_rei_b()
      senao
         escreval("situacao qualquer")
      fimse
   fimse


   montar_tabuleiro()
fimprocedimento

Procedimento movimentos_rei_b()
Var
   i, j: inteiro
   movimento_possivel: logico
Inicio
   movimento_possivel <- falso // Inicialmente assume que nao ha movimentos possiveis

   para i de -1 ate 1 faca
      para j de -1 ate 1 faca
         se (i <> 0) ou (j <> 0) entao  //pra ignorar a propria posicao
            se (xRei_B + i >= 1) e (xRei_B + i <= 8) e (yRei_B + j >= 1) e (yRei_B + j <= 8) entao
               se (tabuleiro[xRei_B + i, yRei_B + j] = "") entao
                  // aqui ele verifica se a posicao ta ameacada
                  se (nao ameaca_dama(xRei_B + i, yRei_B + j)) e (nao ameaca_cavalo(xRei_B + i, yRei_B + j)) e (nao ameaca_rei(xRei_B + i, yRei_B + j)) entao
                     escreval("Casa segura:")
                     escreval("(",xRei_B + i,",", yRei_B + j," )")
                     movimento_possivel <- verdadeiro
                  fimse
               fimse
            fimse
         fimse
      fimpara
   fimpara

   se (nao movimento_possivel) e ((ameaca_cavalo(xRei_B, yRei_B)) ou (ameaca_dama(xRei_B, yRei_B))) entao
      escreval("Xeque-Mate!!!!!!!")
   senao
      se (nao movimento_possivel) e (nao ameaca_cavalo(xRei_B, yRei_B)) e (nao ameaca_dama(xRei_B, yRei_B)) entao
         escreval("Afogamento!!!!!")
      senao
         escreval("")
      fimse
   fimse
fimprocedimento


// verifica se o cavalo ta ameacando o rei_b
Funcao ameaca_cavalo(pecaX, pecaY: inteiro): logico
Var
   diferencaX, diferencaY: inteiro
Inicio
   diferencaX <- abs(pecaX - xCavalo)
   diferencaY <- abs(pecaY - yCavalo)

   se ((diferencaX = 2) e (diferencaY = 1) ou (diferencaX = 1) e (diferencaY = 2)) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

// verifica se o rei ta ameacando o rei_b
Funcao ameaca_rei(pecaX, pecaY: inteiro): logico
Var
   diferencaX, diferencaY: inteiro
Inicio
   diferencaX <- abs(pecaX - xRei)
   diferencaY <- abs(pecaY - yRei)

   se ((diferencaX <= 1) e (diferencaY <= 1)) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

// verifica se a dama ta ameacando o rei_b
Funcao ameaca_dama(pecaX, pecaY: inteiro): logico
Var
   mesmaLinha, mesmaColuna, mesmaDiagonal: logico
Inicio
   mesmaLinha <- (xDama = pecaX)
   mesmaColuna <- (yDama = pecaY)
   mesmaDiagonal <- (abs(xDama - pecaX) = abs(yDama - pecaY))

   se (mesmaLinha ou mesmaColuna ou mesmaDiagonal) entao
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao

Procedimento montar_tabuleiro()
Var
   i, j: inteiro
Inicio
   escreval("======== TABULEIRO DE XADREZ ========")
   escreval("")

   para i de 1 ate 8 faca
      para j de 1 ate 8 faca
         se (tabuleiro[i, j] <> "") entao
            escreva(" ", tabuleiro[i, j], " ")
         senao
            escreva(" . ")
         fimse

         se (j = 8) entao
            escreval("")
         fimse
      fimpara
   fimpara
fimprocedimento

Procedimento reinicializa_tabuleiro()
Var
   i, j: inteiro
Inicio
   para i de 1 ate 8 faca
      para j de 1 ate 8 faca
         tabuleiro[i, j] <- ""
      fimpara
   fimpara
fimprocedimento

// inicio do algoritmo geral
Inicio
   posiciona_peca()
   resposta <- "s"

   enquanto (resposta = "s") faca
      reinicializa_tabuleiro()
      resposta <- repetir_jogo()
   fimenquanto
Fimalgoritmo