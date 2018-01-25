class Player
  attr_reader :name, :turn, :symbol#Getter pour "name", "turn" et "symbol".

  def initialize(name, turn, symbol)
  	@name = name 
  	@turn = turn
  	@symbol = symbol
  end
end
#On créé la fonction "initialize" avec les arguments "name", "turn" et "symbol".
#On créé une variable d'instance pour stocker "name".
#On créé une autre variable d'instance pour stocker "turn".
#On créé une autre variable d'instance pour stocker "symbol".
class TicTacToe
  def initialize
	@board = { :a1 => " ", :a2 => " ", :a3 => " ",
  		       :b1 => " ", :b2 => " ", :b3 => " ",
  		       :c1 => " ", :c2 => " ", :c3 => " " }
  end
#On créé une fonction initialize dans laquelle on établit une variable d'instance pour stocker dans "board" les valeurs par défaut des cases (par le biai de symboles. 
  def display
    puts "     A   B   C"
    puts "   -------------"
    puts " 1 | " + @board[:a1] + " | " + @board[:b1] + " | " + @board[:c1] + " |"
  	puts "   -------------"
  	puts " 2 | " + @board[:a2] + " | " + @board[:b2] + " | " + @board[:c2] + " |"
  	puts "   -------------"
  	puts " 3 | " + @board[:a3] + " | " + @board[:b3] + " | " + @board[:c3] + " |"
  	puts "   -------------"
  end 
#On créé la fonction "display" qui va nous servir à afficher l'interface du jeu.
#On place à l'intérieur des string les symboles de façon à ce que chaque symbole corresponde à sa case.
  def case_choix(player)
    cases = ["a1","a2","a3","b1","b2","b3","c1","c2","c3"]
  	case_ok = false
#On créé la fonction "case_choix" qui prend pour argument "player".
#On établit la variable "cases" dans laquelle on stocke un tableau contenant les string qu'il sera possible, aux joueurs, de rentrer.
#On créé un autre variable "case_ok" qui a pour valeur le booléen "false". Elle nous servira à savoir si la case est déjà remplie.
    
    puts "A ton tour " + player.name.capitalize + ". Selectionne une case:"
    while(case_ok == false)
      case_selected = gets.chomp.downcase
      if !cases.include?(case_selected)
        puts "Entrée incorrecte! Entre une valeur valide (ex: a2, c3, b1)"
        next
      elsif @board[case_selected.to_sym] != " "
      	puts case_selected.to_s.inspect
        puts "Case déjà jouée. Séléctionne-en une autre:"
        next
      else
      	case_ok = true
      end
    end
    case_selected
  end
#On demande au joueur de rentrer le nom d'une case.
#On créé une boucle où on dit que tant que la case est vide, 
#la variable "case_selected" stocke l'entrée de l'utilisateur et la met en minuscule,
#et si l'entrée de l'utilisateur n'est pas inclue dans le tableau de "cases",
#on lui dit de rentrer une valeur valide.
#sinon si le symbole correspondantn à l'entrée du joueur convertie en symbole n'est plus égale à rien comme dans le tableau "@board" ça veut dire que la case à déjà été remplie par une valeur.
#On le signale au joueur par un message.
#sinon la variable "case_ok" prend la valeur true.
#On appelle la variable "case selected"
  def case_remp(case_a_remp, player_symbol)
  	@board[case_a_remp.to_sym] = player_symbol
  end
#La variable "case_remp" servira plus bas à récupérer plus bas dans le code, la case sélectionnée par le joueur ("case_a_remp") et la nature du pion du joueur ("player_symbol").
  def victoire?(sign)
  	resultat = false
    win = [[:a1,:a2,:a3],[:b1,:b2,:b3],[:c1,:c2,:c3],[:a1,:b1,:c1],
           [:a2,:b2,:c2],[:a3,:b3,:c3],[:a1,:b2,:c3],[:a3,:b2,:c1]]
    win.each do |a,b,c|
      if @board[a] == sign && @board[b] == sign && @board[c] == sign
      end
    end
    resultat
  end
#La fonction victoire? prend comme argument "sign" et sert à établir les  critères de victoire.
#La variable "resultat" à pour valeur par défaut "false".
#"win" correspond au tableau référençant toutes le combinaisons gagnantes possibles.
  def start
  	puts "Entre ton nom pour devenir le joueur1?"
  	joueur1 = Player.new(gets.chomp.downcase,1,"X")
  	puts "Comme c'est plus fun de jouer à deux, entre ton nom et tu seras le joueur2?"
  	joueur2 = Player.new(gets.chomp.downcase,2,"O")
  	puts "Le perdant paye sa tournée..."
  	sleep(2)
  	puts "3..."
  	sleep(1)
  	puts "2..."
  	sleep(1)
  	puts "1..."
  	sleep(1)
  	puts "...c'est parti!!!"
  	sleep(1)
#La fonction "start" sert à discuter avec les joueurs pour récupérer leurs noms.
  	joueur = joueur1
    @winner = nil
    stage = 1
    victoire = false
#Variable qui stocke par défaut les infos du joueur1.
#"@winner" est égal à rien par défaut
#"stage" est égal à 1 par défaut. Servira à compter le nombre de coup total.
#"victoire" à par défaut la valeur "false".
    until stage == 10 || @winner
      display
      case_remp(case_choix(joueur),joueur.symbol)
      @winner = joueur.name if victoire?(joueur.symbol)
      stage += 1
    end
#On dit que tant qu'il n'y a pas eu 10 coups jouée ou qu'il n'y a pas de gagnant,
#on appelle la fonction "display" (c'est à dire on affiche la grille de jeu).
#La grille de jeu sera remplie par le pion du joueur à l'emplacement entré (grace à la fonction "case_choix").
#On modifie la valeur de la variable d'instance "@winner" en lui attribuant le nom du joueur si c'est le pion de ce joueur qui gagne.
#"stage" augmente de 1 à chaque coup.
    display
    if @winner
      puts "Bien joué " + @winner.capitalize + " t'as gagné la partie et un coup à boire!"
    else
      puts "Match nul!!!"
    end
    sleep(2)
    puts "N'hésitez pas à reprendre un MAX sensations fortes en relançant une nouvelle partie."
  end
#Si "@winner" n'est plus égal à rien, alors on écrit la phrase contenant le nom du gangnant mis en majuscule.
#Sinon on affiche qu'il y a match nul.
#On attend 2 secondes et on appelle la fonction "fanny".
end
#On ferme la clase TicTacToe.
game = TicTacToe.new
game.start
#On dit que "game" fait appel à la classe TicTacToe.
#On lance la partie en appelant la fonction "start. de TicTacToe.

























