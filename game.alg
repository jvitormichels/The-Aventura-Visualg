algoritmo "The Aventura Alpha 0.0.2"
//Autor: Jo�o Vitor Michels
//trabalhando no shop

var
//mapa e fun��es b�sicas
maporig: vetor [1..9,1..9] de caractere //determina o mapa depois de explorado, guarda o que existe em cada posi��o
map0: vetor [1..9,1..9] de caractere    //determina o mapa inexplorado
x: inteiro //vari�vel de controle de linha dos vetores
y: inteiro //vari�vel de controle de coluna dos vetores
opc: caractere //guarda a op��o escolhida pelo usu�rio
keep: caractere //destina-se a retornar para algo anterior, como fechar um "pop-up"
temp: caractere //guarda o que existe na posi��o seguinte antes que o jogador se mova
opcmanual: caractere //subop��o para escolhas dentro do manual (menu)
new: logico //verdadeiro para um novato e falso para voltar ao jogo

//hp
hpmaxp: inteiro //guarda o hp m�ximo do jogador
hpatp: inteiro //guarda o hp atual do jogador
hpatptemp: inteiro //guarda o hp atual do jogador, para que este seja restaurado caso a speed do jogador seja maior do que a do monstro e ambos tenham zerado seus pontos de hp ao fim de uma rodada

//personagem atual
nvlp: inteiro //guarda o n�vel do jogador
expp: inteiro //guarda a exp atual do jogador
expmax: inteiro //guarda a exp maxima referente ao n�vel em que o jogador
expmaxtemp: inteiro //vari�vel tempor�ria utilizada no c�lculo de exp necess�ria correspondente ao n�vel seguinte
spdp: inteiro //guarda a speed basedo jogador referente ao n�vel em que se encontra
atkp: inteiro //guarda o ataque base do jogador

//pontos de atributo
ptnvl: inteiro //pontos de atributo recebidos ao passar de n�vel - ainda n�o utilizado
ptspdp: inteiro //pontos de atributo investidos em speed - ainda n�o utilizado
pthpp: inteiro //pontos de atributo investidos em hp - ainda n�o utilizado
ptatkp: inteiro //pontos de atributo investidos em atk - ainda n�o utilizado

//armas
idarma: inteiro //guarda a identifica��o da arma
namearma: vetor [1..5] de caractere //guarda o nome das armas segundo seu id
atkarma: vetor [1..5] de inteiro //guarda o atk das armas segundo seu id
qualidadearma: vetor [1..5] de caractere //guarda a qualidade das armas segundo seu id

//rodada
rodada: inteiro //guarda o n�mero de rodadas pelas quais o jogador j� passou

//monstros
sortmon: inteiro //vari�vel respons�vel por sortear o id do monstro na presente posi��o
presentmon: inteiro //respons�vel por decidir entre presen�a ou aus�ncia de monstros na presente posi��o
idmon: inteiro //guarda a identifica��o dos monstros e os diferencia
namemon: vetor [1..3] de caractere //guarda o nome dos monstros segundo seu id
expmon: vetor [1..3] de inteiro //guarda o valor de pontos de exp que o jogador recebe ao matar cada monstro, segundo seu id
hpmaxmon: vetor [1..3] de inteiro //guarda o hp m�ximo dos monstros segundo seu id
hpatmon: inteiro //guarda o hp atual do monstro em batalha com o jogador
atkmon: vetor [1..3] de inteiro //guarda o atk do monstro segundo seu id
spdmon: vetor [1..3] de inteiro //guarda a speed do monstro segundo seu id

//indefinido
atkptemp: inteiro //vari�vel utilizada durante o c�lculo do b�nus de dano
bonusdano: inteiro //guarda o valor de dano b�nus referente ao atk base do personagem, � adicionado ao dano da arma durante o c�lculo de dano de um ataque lan�ado pelo jogador
danopm: inteiro //guarda o dano que o jogador recebe proveniente do ataque do monstro - atualmente n�o utilizada, receber� sua fun��o quando for adicionado o sistema de multiplicadores
danomp: inteiro //guarda o dano que o monstro recebe proveniente do ataque do jogador - atualmente n�o utilizada, receber� sua fun��o quando for adicionado o sistema de multiplicadores

//itens
iditem: inteiro //usado para se referir a cada item nos vetores que guardam suas respectivas informa��es
nameitem: vetor [1..3] de caractere //guarda o nome dos itens, posi��es referenciadas pela vari�vel de controle iditem
item_sell_value: vetor [1..3] de inteiro //guarda o pre�o de venda dos itens

//invent�rio
idinv: inteiro //usado para se referir �s posi��es do invent�rio
iteminv: vetor [1..7] de caractere //guarda os nomes dos itens que est�o no invent�rio
inv_item_quant: vetor [1..7] de  inteiro //guarda a quantidade de cada item que est� no invent�rio, referenciado pela variavel de controle id_inv
player_money: inteiro //guarda o valor em moedas que o jogador possui
id_item_inv: vetor [1..7] de inteiro //guarda o id do item que preenche um slot de armazenamento no invent�rio, utilizado para se referir ao item em si

procedimento start(): inteiro
  inicio

    //declara��o de armas
    namearma[1]:="Espada curta de uma m�o"
    qualidadearma[1]:="Comum"
    atkarma[1]:=11

    namearma[2]:="Cimitarra"
    qualidadearma[2]:="Comum"
    atkarma[2]:=12

    namearma[3]:="Espada longa de duas m�os"
    qualidadearma[3]:="Comum"
    atkarma[3]:=13
    //fimarmas


    //declara��o de monstros
    namemon[1]:=("Slime comum")
    expmon[1]:=27
    hpmaxmon[1]:=25
    atkmon[1]:=5
    spdmon[1]:=10


    namemon[2]:=("Slime negro")
    expmon[2]:=35
    hpmaxmon[2]:=30
    atkmon[2]:=8
    spdmon[2]:=11

    namemon[3]:=("Zumbi")
    expmon[3]:=47
    hpmaxmon[3]:=40
    atkmon[3]:=5
    spdmon[3]:=9
    //fimmonstros

    //declara��o de itens
    nameitem[1]:="Gosma de Slime"
    item_sell_value[1]:=8

    nameitem[2]:="Pedra da alma"
    item_sell_value[2]:=10

    nameitem[3]:="Pedra m�gica"
    item_sell_value[3]:=12
    //fimitens


    para y:=1 ate 9 faca
      maporig[1,y]:="w"
      maporig[9,y]:="w"
      map0[1,y]:="w"
      map0[9,y]:="w"
    fimpara

    para x:=2 ate 8 faca
      maporig[x,1]:="w"
      maporig[x,9]:="w"
      map0[x,1]:="w"
      map0[x,9]:="w"
    fimpara

    para x:=2 ate 8 faca
      para y:=2 ate 8 faca
          maporig[x,y]:="c"
      fimpara
    fimpara

    maporig[5,5]:="$"

    para x:=2 ate 8 faca
      para y:=2 ate 8 faca
          map0[x,y]:="�"
      fimpara
    fimpara

    player_money:=250
    nvlp:=1 //ajusta o n�vel inicial do jogador para 1
    expmax:=300 //ajusta o exp referente ao n�vel inicial do jogador
    hpmaxp:=50 //ajusta o hp m�ximo inicial do jogador para 1
    hpatp:=hpmaxp //ajusta o hp atual inicial do jogador para que este se iguale ao hp m�ximo inicial do jogador, ou seja, hp cheio
    spdp:=10 //ajusta a speed inicial do jogador
    atkp:=6 //ajusta o atk desarmado inicial do jogador
    bonusdano:=1 //bonus de dano inicial segundo o ataque base inicial do jogador
    idarma:=1 //id da arma inicial do jogador
    x:=5 //posi��o inicial do jogador
    y:=5 //posi��o inicial do jogador
    map0[5,5]:="@" //identifica��o visual da posi��o inicial do jogador
    rodada:=1 //n�mero da rodada inicial do jogo

    para idinv:=1 ate 7 faca
      iteminv[idinv]:="Vazio"
    fimpara
fimprocedimento

procedimento shop(): caractere
  var
  opcs: caractere
  sairs: logico
  i: inteiro
  opc_venda: caractere

  inicio
    opcs:="0"
    sairs:=falso
    enquanto (sairs=falso) faca
      opcs:="none"
      enquanto (opcs<>"1") e (opcs<>"2") e (opcs<>"0") faca
        escreval("SHOP")
        escreval
        escreval("1.Comprar") //ainda n�o feito
        escreval("2.Vender")
        escreval
        escreval("0.Sair")
        leia(opcs)
        limpatela
      fimenquanto

      se (opcs="0") entao
        sairs:=verdadeiro
      fimse

      se (opcs="1") entao
        escreval("Essa parte do shop ainda est� em constru��o")
        escreval
        escreval
        escreval("Aperter enter para continuar")
        leia(keep)
        limpatela
      fimse

      se (opcs="2") entao
        se (iteminv[1]<>"Vazio") entao
          escreval("Vender")
          escreval
          para i:=1 ate 7 faca
            se (iteminv[i]="Vazio") entao
              interrompa
            fimse
            escreval(iteminv[i],"  x",inv_item_quant[i])
          fimpara
          escreval
          leia(opc_venda)
        fimse
      fimse
      se (iteminv[1]="Vazio") entao
        escreval("N�o h� nada em sua mochila!")
        escreval
        escreval
        escreval("Aperte Enter para continuar")
        leia(keep)
        limpatela
      fimse
      limpatela
    fimenquanto
fimprocedimento


procedimento drop(): inteiro //encarregado do drop dos monstros
  var
  drop1: logico //diz se existem drops na primeira posi��o da lista
  drop2: logico //diz se existem drops na segunda posi��o da lista
  id_drop: inteiro //referencia os drops para o caso de m�ltiplos itens

  sort_drop: inteiro   //decide se o monstro dropa ou n�o os itens a ele designados

  name_item_drop: vetor [1..2] de caractere //guarda o nome dos itens dropados
  drop_quant: vetor [1..2] de inteiro //guarda a quantidade de itens dropados
  opc_drops: caractere //guarda o valor da posi��o cujo item o jogador deseja obter detalhes ou adicionar ao invent�rio

  coletado: logico

  inicio
    idinv:=1
    id_drop:=1
    coletado:=falso
    drop1:= falso //reset de vari�vel
    drop2:=falso //reset de vari�vel
    se (idmon=1) ou (idmon=2) entao //slime comum e slime negro
      sort_drop:=randi(4) //sorteia a quantidade de bolas de slime que esse slime dropou
      //slimes comuns dropam de 1 a 3 gosmas de slime cada
      se (sort_drop=0) entao //se a quantidade sorteada for igual a 0, a quantidade dropada deve ser igualada a 1
        sort_drop:=1 //100% de chance
      fimse
      name_item_drop[1]:=nameitem[1] //gosma de slime de slime
      drop_quant[1]:=sort_drop
      drop1:= verdadeiro
    fimse

    se (idmon=3) entao //zumbi
      name_item_drop[1]:=nameitem[2]
      drop_quant[1]:=randi(4)
      se(drop_quant[1]<>0) entao
        drop1:=verdadeiro
      fimse
    fimse

    se (drop1=verdadeiro) entao
      escreval
      enquanto (opc_drops<>"0") e (opc_drops<>"1") e (opc_drops<>"2") faca
        escreval("Lista de drops")
        escreval("1.",name_item_drop[1],"   x",drop_quant[1])

        //para monstros que dropam v�rios itens - ainda n�o utilizado
        se(drop2=verdadeiro) entao
          id_drop:=id_drop+1
          escreval("2. ",name_item_drop[id_drop],"   x",drop_quant[id_drop])
        fimse

        escreval
        escreval("[num] para obter detalhes e coletar drops")
        escreval("0 para n�o pegar nada")
        leia (opc_drops)
        limpatela
      fimenquanto

      id_drop:=caracpnum(opc_drops)


      se(opc_drops<>"0") entao
        enquanto (coletado=falso) e (idinv<8) faca
          se(iteminv[idinv]="Vazio") ou (iteminv[idinv]=name_item_drop[id_drop]) entao
            se (iteminv[idinv]="Vazio") entao
              iteminv[idinv]:=name_item_drop[id_drop]
              inv_item_quant[idinv]:=drop_quant[id_drop]
              coletado:=verdadeiro
            fimse
            se (iteminv[idinv]=name_item_drop[id_drop]) e (coletado=falso) entao
              inv_item_quant[idinv]:=inv_item_quant[idinv]+drop_quant[id_drop]
              coletado:=verdadeiro
            fimse
          fimse
          se (coletado=falso) entao
            idinv:=idinv+1
          fimse
          se (coletado=falso) e (idinv=8) entao
            escreval("Invent�rio lotado!")
            escreval
            escreval
            escreval("Aperte enter para continuar")
            leia(keep)
            limpatela
          fimse
        fimenquanto
      fimse
    fimse
fimprocedimento


inicio
  opc:="m"
  enquanto (opc="m") ou (opc="r") faca
    enquanto ((opc="l") ou (opc="m") ou (opc="c") ou (opc="0")) ou ((opc<>"n") e (opc<>"l") e (opc<>"m") e (opc<>"c") e (opc<>"r")) ou ((opc="r") e (nvlp<>1)) faca
      se(nvlp<>0) entao
        escreval("Resume game (r)")
      fimse
      escreval("New (n)")
      escreval("Load (l)")
      escreval("Manual (m)")
      escreval("Cr�ditos (c)")
      escreval("Sair (s)")
      escreval
      leia(opc)
      limpatela

      se (opc="s") entao
      fimalgoritmo
    fimse

    se(opc="c") entao
      escreval("Desenvolvedor: Jo�o Vitor Michels")
      escreval("Data de in�cio: 30/03/2019")
      escreval("Programado em pseudoc�digo para sistema Visualg")
      escreval
      escreval
      escreval("Aperte enter para retornar")
      leia(keep)
      limpatela
    fimse

    se(opc="m") entao //manual
      escreval("1.Interface (1)")
      escreval
      escreval
      escreval("Aperte Enter para retornar")
      leia(opcmanual)
      se (opcmanual="1") entao
        limpatela
        escreval("JOGO")
        escreval("      O jogador � colocado em um mapa 9x9, cujo contorno � de �gua, portanto,")
        escreval("inacess�vel.")
        escreval("      Ao jogador � dada a possibilidade de se mover, matar monstros variados,")
        escreval("adquirir itens e equip�-los, assim como upar e distribuir pontos de atributo")
        escreval("como bem quiser.")
        escreval
        escreval("COMANDOS DE JOGO")
        escreval("      Para realizar qualquer a��o poss�vel, o usu�rio deve inserir o caractere")
        escreval("correspondente, segundo a legenda, e, ent�o, teclar Enter para confirmar.")
        escreval
        escreval
        escreval("Aperte enter para retornar")
        leia(keep)
      fimse
      limpatela
    fimse

    se (opc="l") entao
      escreval("Perd�o, o recurso selecionado ainda n�o est� dispon�vel.")
      escreval("A op��o de carregar um jogo anterior deve ser implementada em breve.")
      escreval
      escreval("Aperte enter para retornar ao menu")
      leia(keep)
      se (keep="") entao
        limpatela
      fimse
      limpatela
    fimse
  fimenquanto

  se (opc="n") ou ((opc="r") e (nvlp<>0)) entao //define os par�metros iniciais
    se(nvlp=0)entao
      start()
    fimse

    enquanto (hpatp>0) e (opc<>"m") faca //enquanto o jogador est� vivo e n�o decide retornar ao menu
      presentmon:=0
      enquanto (expp>expmax) faca //entra quando o jogador upa de n�vel
        nvlp:=nvlp+1 //up do n�vel do jogador
        expp:=expp-expmax //guarda a exp que sobrou ao jogador, sendo carregada para o pr�ximo n�vel
        expmaxtemp:=expmax
        enquanto (expmaxtemp>5) faca
          expmaxtemp:=expmaxtemp-5
          expmax:=expmax+5
        fimenquanto
        hpmaxp:=hpmaxp+2
        hpatp:=hpmaxp
        spdp:=spdp+1
        atkp:=atkp+2
        atkptemp:=atkp
        enquanto (atkptemp>=4) faca
          enquanto (atkptemp>=40) faca
            bonusdano:=bonusdano+10
            atktemp:=atktemp-40
          fimenquanto
          bonusdano:=bonusdano+1
          atkptemp:=atkptemp-4
        fimenquanto

        escreval
        escreval
        escreval
        escreval("                          @@@@@@@@@@@@@@@@@@@@@@@@@@@")
        escreval
        escreval("                             Voc� conseguiu 1 n�vel")
        escreval("                             hp+1=",hpmaxp,)
        escreval("                             atk+1=",atkp)
        escreval("                             spd+1=",spdp)
        escreval
        escreval("                          @@@@@@@@@@@@@@@@@@@@@@@@@@@")
        escreval
        escreval
        escreval("Aperte Enter para retornar")
        leia(keep)
        limpatela
      fimenquanto
      opc:="0"
      enquanto (opc<>"1") e (opc<>"2") e (opc<>"3") e (opc<>"4") e (opc<>"5") e (opc<>"m") e (opc<>"i") e (opc<>"s") e (opc<>"h") faca
        escreval("                                 Rodada: ",rodada)
        escreval("                                  ",y," -",x)
        escreval("                                 ",map0[1,1],map0[1,2],map0[1,3],map0[1,4],map0[1,5],map0[1,6],map0[1,7],map0[1,8],map0[1,9])
        escreval("                                 ",map0[2,1],map0[2,2],map0[2,3],map0[2,4],map0[2,5],map0[2,6],map0[2,7],map0[2,8],map0[2,9])
        escreval("                                 ",map0[3,1],map0[3,2],map0[3,3],map0[3,4],map0[3,5],map0[3,6],map0[3,7],map0[3,8],map0[3,9])
        escreval("                                 ",map0[4,1],map0[4,2],map0[4,3],map0[4,4],map0[4,5],map0[4,6],map0[4,7],map0[4,8],map0[4,9])
        escreval("                                 ",map0[5,1],map0[5,2],map0[5,3],map0[5,4],map0[5,5],map0[5,6],map0[5,7],map0[5,8],map0[5,9])
        escreval("                                 ",map0[6,1],map0[6,2],map0[6,3],map0[6,4],map0[6,5],map0[6,6],map0[6,7],map0[6,8],map0[6,9])
        escreval("                                 ",map0[7,1],map0[7,2],map0[7,3],map0[7,4],map0[7,5],map0[7,6],map0[7,7],map0[7,8],map0[7,9])
        escreval("                                 ",map0[8,1],map0[8,2],map0[8,3],map0[8,4],map0[8,5],map0[8,6],map0[8,7],map0[8,8],map0[8,9])
        escreval("                                 ",map0[9,1],map0[9,2],map0[9,3],map0[9,4],map0[9,5],map0[9,6],map0[9,7],map0[9,8],map0[9,9])

        se((x<>4) e (y<>4) e (y<>5) e (y<>6)) ou ((x<>5) e (y<>4) e (y<>5) e (y<>6)) ou ((x<>6) e (y<>4) e (y<>5) e (y<>6)) entao
          presentmon:=randi(100)
        fimse
        se(presentmon>=30) entao
          sortmon:=randi(100)
          se(sortmon<50) entao
            idmon:=1
          fimse
          se (sortmon>=50) e (sortmon<80) entao
            idmon:=2
          fimse
          se(sortmon>=80) entao
            idmon:=3
          fimse
          escreval(namemon[idmon]," (nvl.2)")
        senao
          escreval
        fimse

        escreval
        escreval("HP: ",hpatp,"/",hpmaxp)
        escreval

        se(presentmon>=30) entao
          escreval("1.Direita   3.Cima       5.Interagir com entidade")
        senao
          escreval("1.Direita   3.Cima")
        fimse
        escreval("2.Esquerda  4.Baixo")
        escreval
        se (x=5) e (y=5) entao
          escreval("S.Shop      H.Heal")
        senao
          escreval
        fimse
        escreval
        escreval("I.Invent�rio")
        escreval("M.Menu")
        escreval
        escreval("XP at� o pr�ximo n�vel: ",expmax-expp)
        leia(opc)
        limpatela
      fimenquanto
      
      se (opc="h") entao
        escreval("HP atual: ",hpatp,"/",hpmaxp)
        escreval("Dinheiro: ",player_money)
        escreval
        escreval("Deseja usar o servi�o de cura? (S/N)")
        escreval("Custo: 10�")
        leia(opc)
        se (opc="s") entao
        hpatp:=hpmaxp
        player_money:=player_money-10
        fimse
        limpatela
        opc:="0"
      fimse

      se (opc="S") e ((x=5) e (y=5)) entao //shop, as coordenadas t�m dois par�nteses pois futuramente existir� shops em outras localidades
        shop()
      fimse

      se(opc="i") entao
        para idinv:=1 ate 7 faca
          escreval("x",inv_item_quant[idinv],"   ",iteminv[idinv])
        fimpara
        escreval
        escreval(player_money,"�")
        escreval
        escreval("E.Equipamento")
        escreval
        escreval
        escreval("Aperte enter para retornar")
        leia(opc)
        limpatela

        se(opc="e") entao
          escreval("Arma: ",namearma[idarma])
          escreval("-Qualidade: ",qualidadearma[idarma])
          escreval("-Dano: ",atkarma[idarma])

          escreval
          escreval
          escreval("Aperte Enter para retornar")
          leia(keep)
          limpatela
        fimse
      fimse

      se (opc="1") entao
        se (map0[x,y+1]="w") entao
          escreval("Dire��o inv�lida, cabe�a de marimo! (Tem �gua pra l�)")
          escreval
          escreval("Aperte enter para retornar")
          leia(keep)
          limpatela
        fimse

        se (map0[x,y+1]<>"w") entao
          rodada:=rodada+1
          y:=y+1
          se (map0[x,y]="�") entao
            temp:=maporig[x,y]
          fimse
          se (map0[x,y]<>"�") entao
            temp:=map0[x,y]
          fimse
          map0[x,y-1]:=maporig[x,y-1]
          map0[x,y]:="@"
          limpatela
        fimse
      fimse

      se (opc="2") entao
        se (map0[x,y-1]="w") entao
          escreval("Dire��o inv�lida, cabe�a de marimo! (Tem �gua pra l�)")
          escreval
          escreval("Aperte enter para retornar")
          leia(keep)
          limpatela
        fimse

        se (map0[x,y-1]<>"w") entao
          rodada:=rodada+1
          y:=y-1
          se (map0[x,y]="�") entao
            temp:=maporig[x,y]
          fimse
          se (map0[x,y]<>"�") entao
            temp:=map0[x,y]
          fimse
          map0[x,y+1]:=maporig[x,y+1]
          map0[x,y]:="@"
          limpatela
        fimse
      fimse

      se (opc="3") entao
        se (map0[x-1,y]="w") entao
          escreval("Dire��o inv�lida, cabe�a de marimo! (Tem �gua pra l�)")
          escreval
          escreval("Aperte enter para retornar")
          leia(keep)
          limpatela
        fimse

        se (map0[x-1,y]<>"w") entao
          rodada:=rodada+1
          x:=x-1
          se (map0[x,y]="�") entao
            temp:=maporig[x,y]
          fimse
          se (map0[x,y]<>"�") entao
            temp:=map0[x,y]
          fimse
          map0[x+1,y]:=maporig[x+1,y]
          map0[x,y]:="@"
          limpatela
        fimse
      fimse

      se (opc="4") entao
        se (map0[x+1,y]="w") entao
          escreval("Dire��o inv�lida, cabe�a de marimo! (Tem �gua pra l�)")
          escreval
          escreval("Aperte enter para retornar")
          leia(keep)
          limpatela
        fimse

        se (map0[x+1,y]<>"w") entao
          rodada:=rodada+1
          x:=x+1
          se (map0[x,y]="�") entao
            temp:=maporig[x,y]
          fimse
          se (map0[x,y]<>"�") entao
            temp:=map0[x,y]
          fimse
          map0[x-1,y]:=maporig[x-1,y]
          map0[x,y]:="@"
          limpatela
        fimse
      fimse

      se (opc="5") entao
        hpatmon:=hpmaxmon[idmon]
        enquanto (hpatp>0) e (hpatmon>0) e (opc<>"2") faca
          se (idmon=1) ou (idmon=2) entao
            escreval("                          --    ")
            escreval("                         .x- -  ")
            escreval("                   .;-==,,+;+=.;")
            escreval("                -##x#####...=. ,")
            escreval("               ######XX###==##  ")
            escreval("              ######xxx######## ")
            escreval("              #X##X+##xx+###X## ")
            escreval("              #x-;+###Xxx=-=x## ")
            escreval("              ##;;+xxxxxx-,,+## ")
            escreval("               =+xxxxxxxxx++x+  ")
          fimse
          escreval
          escreval(namemon[idmon])
          escreval("HP: ",hpatmon,"/",hpmaxmon[idmon])
          escreval
          escreval("Jogador")
          escreval("HP: ",hpatp,"/",hpmaxp)
          escreval
          escreval

          escreval("1.Atacar")
          escreval("2.Fugir como uma gazela")
          leia(opc)
          limpatela

          se(opc="1") entao
            hpatmon:=hpatmon-(atkarma[idarma]+bonusdano)
          fimse

          se (opc="1") entao //ou outras formas de descer a porrada no monstro
            hpatptemp:=hpatp
            hpatp:=hpatp-atkmon[idmon]
          fimse

          se(hpatp<=0) e (hpatmon<=0) entao
            se (spdp>spdmon[idmon]) entao
              hpatp:=hpatptemp
              escreval("                              O ",namemon[idmon]," foi mais r�pido que voc� e acertou o golpe antes")
            fimse
          fimse

          se (hpatp>0) e (hpatmon<=0) entao
            expp:=expp+expmon[idmon]
            escreval("Voc� derrotou o ",namemon[idmon]," e recebeu ",expmon[idmon]," pontos!")
            drop()
          fimse
          limpatela
        fimenquanto //enquanto (hpatp>0) e (hpatmon>0)
      fimse //se (opc="5")
    fimenquanto //enquanto (hpatp>0) e (opc<>"m") faca

    se(hpatp<=0) entao
        escreval("                              VOC� MORREU!")
    fimse

  fimse //se (opc="n")
  fimenquanto //enquanto (opc="m")
fimalgoritmo