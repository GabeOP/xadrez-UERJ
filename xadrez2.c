// Gabriel de Oliveira Pereira
// Pedro Henrique  dos Santos Wippwl Bezerra

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void posicionaPeca(char tabuleiro[8][8], int linha, int coluna) {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            tabuleiro[i][j] = '.';
        }
    }
    tabuleiro[linha][coluna] = 'C';
}

void montaTabuleiro(char tabuleiro[8][8]) {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%c ", tabuleiro[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

// pra verificar se o proximo movimento estará dentro dos limites do tabuleiro
int movimentoValido(int linha, int coluna) {
    return linha >= 0 && linha < 8 && coluna >= 0 && coluna < 8;
}

// pra criar uma aleatoriedade nos movimentos. Cada vez q ele for chamado, o array movimentosCavalo terá a ordem dos movimentos modificada
// nao estou usando ponteiro pois o proprio array sendo passado é o endereço de memoria
void embaralhar(int movimentos[8][2]) {
    for (int i = 0; i < 8; i++) {
        int j = rand() % 8;
        int temp0 = movimentos[i][0];
        int temp1 = movimentos[i][1];
        movimentos[i][0] = movimentos[j][0];
        movimentos[i][1] = movimentos[j][1];
        movimentos[j][0] = temp0;
        movimentos[j][1] = temp1;
    }
}

int main(void) {
    char tabuleiro[8][8];
    int linha, coluna, n = 0;

    // todos possiveis movimentos em L
    int movimentosCavalo[8][2] = {
        {2, 1}, {2, -1}, {-2, 1}, {-2, -1},
        {1, 2}, {1, -2}, {-1, 2}, {-1, -2}
    };

    srand(time(NULL));

    do {
        printf("Posicao inicial -> ");
        scanf("%d %d", &linha, &coluna);
    } while (linha < 1 || linha > 8 || coluna < 1 || coluna > 8);

    linha -= 1;
    coluna -= 1;

    posicionaPeca(tabuleiro, linha, coluna);
    montaTabuleiro(tabuleiro);

    int movimentosDisponiveis = 1;
    while (movimentosDisponiveis) {
        movimentosDisponiveis = 0;
        embaralhar(movimentosCavalo);  // embaralha os movimentos a cada iteracao

        //para tentar encontrar um movimento valido pro cavalo dentro do array movimentosCavalo
        for (int i = 0; i < 8; i++) {
            int novaLinha = linha + movimentosCavalo[i][0];
            int novaColuna = coluna + movimentosCavalo[i][1];

            if (movimentoValido(novaLinha, novaColuna) && tabuleiro[novaLinha][novaColuna] == '.') {
                n++;
                tabuleiro[linha][coluna] = '#';
                linha = novaLinha;
                coluna = novaColuna;
                tabuleiro[linha][coluna] = 'C';
                movimentosDisponiveis = 1;
                montaTabuleiro(tabuleiro);
                break;
            }
        }
    }

    printf("Casas visitadas: %i\n", n);
    printf("Casas NAO visitadas: %i\n", 64 - n);
    return 0;
}
