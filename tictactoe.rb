class Game
    WINNING_COMBOS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
    ]
    
      def initialize
       @players = Players.new
      end
    #LA METHODE MOVE GERE LE GAMEPLAY 
      def move
        @end = false
        @gameboard = Board.new
        @turn = 1
        while @turn<10 
          if @turn % 2 != 0
              turn_sequence(@players.player1, "X")
          elsif @turn % 2 == 0
              turn_sequence(@players.player2, "O")
          end
        end
      end
    #LA METHODE TURN SEQUENCE GERE LE CHOIX DE LA POSITION ET LE CHANGEMENT DE TOUR DE JOUEUR 
      def turn_sequence (player, symbol)
        puts "#{player}(#{symbol}) please choose a position"
        @player_move = gets.chomp.to_i
        if (0..8).include?(@player_move) && @gameboard.board[@player_move] == " " && @end == false
          @turn += 1
          @gameboard.board_update(@player_move, symbol)
          win_check
          draw_check
        else
          puts "Please enter a number between 0 to 8 in an untaken location\n"
        end
      end
    #LA METHODE POUR VERIFIER LE TABLEAU DE BORD PAR RAPPORT AUX COMBINAISONS GAGNANTES POUR VERIFIER S'IL Y A UN GAGNANT
      def win_check
        WINNING_COMBOS.each do |win_check|
          if (@gameboard.board[win_check[0]] == @gameboard.board[win_check[1]] && 
            @gameboard.board[win_check[1]] == @gameboard.board[win_check[2]]) &&
            @gameboard.board[win_check[0]] != " "
            if @gameboard.board[win_check[0]] == "X"
              puts "#{@players.player1} WINS"
              @turn = 10
              @end = true
              play_again?
            elsif @gameboard.board[win_check[0]] == "O"
              puts "#{@players.player2} WINS"
              @turn = 10
              @end = true
              play_again?
            end
          end
        end
      end
    #LA METHODE POUR DETERMINER SI TOUT LES POSTES SONT POURVUS SANS VICTOIRE    
      def draw_check
        if @turn == 10 && @end == false
          puts "It's a draw"
          play_again?
        end
      end
    #LA METHODE POUR DEMANDER AU JOUEUR S'IL SOUHAITE REJOUER
      def play_again?
        puts "Play again? (Y/N)"
          response = ""
          while response != "Y" || response != "N"
            response = gets.chomp.upcase
              if response == "Y"
                newgame = Game.new
                newgame.move  
              elsif response == "N"
              else 
                puts "Please enter (Y/N)"
              end
          end
      end
    end
    #LA CLASSE QUI GERE LA DEMANDE DE NOM DE JOUEUR ET l'INITIALISATION DES VARIABLES D'INSTANCES DE JOUEUR 
    class Players
      attr_reader :player1, :player2
      
      def initialize
        puts "Player 1, please enter your name"
        @player1 = gets.chomp
        puts "#{@player1} is X"
        puts "Player 2, please enter your name"
        @player2 = gets.chomp
        puts "#{@player2} is O"
      end
    
    end
    #LA CLASSE QUI GERE TOUT CE QUI CONCERNE L'AFFICHAGE DU TABLEAU, LA MISE A JOUR DU TABLEAU ET LA CREATION DU TABLEAU LUI-MEME
    class Board
      attr_reader :board
          
      def initialize
        puts "On your turn enter one of the following numbers to place your piece in the corresponding location:"
        puts ""
        puts "0 | 1 | 2"
        puts "---------"
        puts "3 | 4 | 5"
        puts "---------"
        puts "6 | 7 | 8"
        puts ""
        @board = [" "," "," "," "," "," "," "," "," "]
      end
    #METHODE POUR METTRE A JOUR LE TABLEAU @BOARD AVEC "X" OU "O"
      def board_update(position, symbol)
        @board[position] = symbol
        game_board_display(@board)
      end
    #METHODE QUI AFFICHE LA CARTE DE MISE A JOUR APRES CHAQUE TOUR 
      def game_board_display (board)
        puts "#{board[0]} | #{board[1]} | #{board[2]}"
        puts "---------"
        puts "#{board[3]} | #{board[4]} | #{board[5]}"
        puts "---------"
        puts "#{board[6]} | #{board[7]} | #{board[8]}"
      end
      
    end
    game = Game.new
    game.move  
  