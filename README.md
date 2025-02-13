# Verificador de Xeque

Código feito em Portugol.
O código recebe a posição de 4 peças: uma dama, um cavalo e um  rei de um time e do outro há apenas o rei. A partir das posições, deve ser verificada a situação do rei (se está em afogamento, xeque, xeque-mate ou uma situação qualquer).

### O algoritmo deve cumprir com os seguintes requisitos mínimos: 
- as posições de todas as peças devem ser inseridas pelo usuário e entradas  inválidas devem ser impedidas; 
- a configuração de tabuleiro deve ser exibida na tela (sugestão: use letras como  R para representar o rei, C para o cavalo, X para o rei a ser atacado, etc.); ∙ caso o rei a ser atacado não esteja em xeque, mas não tenha opção de  movimento, deve ser indicado que aconteceu um empate por afogamento;
- caso o rei a ser atacado esteja em xeque, mas tenha opções de escape, devem  ser indicadas as saídas possíveis; 
- caso o rei a ser atacado não esteja diretamente ameaçado, devem ser  indicados os movimentos possíveis; 
- após a avaliação de uma configuração de tabuleiro, deve-se perguntar ao  usuário se deseja testar uma nova configuração. 

# Cavalo desgovernado

Código feito em C.
O código recebe uma posição qualquer e válida para posicionar a peça cavalo. O objetivo do algoritmo é fazer com que a peça visite todas as casas possíveis (respeitando as regras de seu movimento em L) sem repetir nenhuma, até que fique preso ou visite todas as casas.

A cada movimento do cavalo,  a casa que ele visitou deve ser marcada e a configuração do tabuleiro deve ser mostrada para o usuário.
